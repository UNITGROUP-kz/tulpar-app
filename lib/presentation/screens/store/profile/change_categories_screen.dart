import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/extends/list.dart';
import 'package:garage/data/params/profile/change_category_params.dart';
import 'package:garage/logic/bloc/store/change_category/change_category_cubit.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/form/pickers/car_model_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/car_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/group_picker.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../../data/models/auth/store_model.dart';
import '../../../../logic/bloc/store/auth/auth_store_cubit.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/pickers/multi_producer_car_model_picker.dart';
import '../../../widgets/form/pickers/producer_picker.dart';
import '../../../widgets/navigation/header.dart';

@RoutePage()
class ChangeCategoryScreen extends StatefulWidget {
  @override
  State<ChangeCategoryScreen> createState() => _ChangeCategoryScreenState();
}

class _ChangeCategoryScreenState extends State<ChangeCategoryScreen> {
  late GroupController _groupController;
  late MultiProducerCarModelController _multiController;

  @override
  void initState() {
    StoreModel? store = context.read<AuthStoreCubit>().state.store;
    List<MultiProducerCarModelValue> value = store?.categories?.producers.mapWithIndex((e, i) {
      return MultiProducerCarModelValue(
          producerController: ProducerController(value: e),
          carModelController: CarModelController(value: store.categories?.models[i]),
          carApiController: CarApiController(value: store.categories!.cars[i].car),
          update: false
      );
    }).toList() ?? [];
    _multiController = MultiProducerCarModelController(
      value: value
    );
    _groupController = GroupController(value: GroupControllerValue(
      choseChild: store?.categories?.groups ?? [], checkParent: []
    ));
    super.initState();
  }

  @override
  void dispose() {
    _groupController.dispose();
    _multiController.dispose();
    super.dispose();
  }

  _create() {
    if(_check()) {
      context.read<ChangeCategoryCubit>().change(ChangeCategoryParams(
          producers: _multiController.value.map((e) => e.producerController.value!.id).toList(),
          models: _multiController.value.map((e) => e.carModelController.value!.id).toList(),
          groups: _groupController.value.choseChild.map((e) {
            return e.id;
          }).toList()
        )
      );
    }
  }

  _check() {
    return true;
  }

  _listener(BuildContext context, ChangeCategoryState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == FetchStatus.success) {
      _back();
    }
  }

  _back() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        const Header(title: 'Изменить услуги', isBack: true),
        const SizedBox(height: 10),
        MultiProducerCarModelPicker(controller: _multiController),
        const SizedBox(height: 10),
        // GroupPicker(isMulti: true, controller: _partController),
        const SizedBox(height: 10),
        BlocConsumer<ChangeCategoryCubit, ChangeCategoryState>(
          listener: _listener,
          builder: (context, state) {
            if(state.status == FetchStatus.loading) {
              return ElevatedButtonWidget(
                  onPressed: () {},
                  child: CupertinoActivityIndicator(color: Colors.black45)
              );
            }
            return MultiValueListenableBuilder(
                valuesListenable: [
                  _multiController,
                  _groupController
                ],
                builder: (context, value, child) {
                  bool isValid = value[0].every((element) => element.carModelController.value != null && element.producerController.value != null)
                    && value[1].choseChild.isNotEmpty;

                  return ElevatedButtonWidget(
                      onPressed: isValid ? _create : null,
                      child: Text('Изменить услуги')
                  );
                }
            );
          },
        )


      ],
    );
  }
}


