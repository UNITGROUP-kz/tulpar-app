import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/fform/forms/create_car_form.dart';
import 'package:garage/data/params/car/create_car_params.dart';
import 'package:garage/logic/bloc/user/create_car/create_car_cubit.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/form/fields/text_field.dart';
import 'package:garage/presentation/widgets/form/pickers/car_model_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/part_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/volume_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/year_picker.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/pickers/producer_picker.dart';
import '../../../widgets/navigation/header.dart';

@RoutePage()
class ChangeCategoryScreen extends StatefulWidget {
  @override
  State<ChangeCategoryScreen> createState() => _ChangeCategoryScreenState();
}

class _ChangeCategoryScreenState extends State<ChangeCategoryScreen> {
  late ProducerController _producerController;
  late CarModelController _carModelController;
  late PartController _partController;

  @override
  void initState() {
    _producerController = ProducerController()..addListener(_listenerProducer);
    _carModelController = CarModelController();
    _partController = PartController();
    super.initState();
  }

  _listenerProducer() {
    _carModelController.remove();
  }

  @override
  void dispose() {
    _producerController.removeListener(_listenerProducer);
    _producerController.dispose();
    _carModelController.dispose();
    _partController.dispose();
    super.dispose();
  }

  _create() {
    if(_check()) {
      // context.read<CreateCarCubit>().create(CreateCarParams(
      //     model: _carModelController.value!,
      //     producer: _producerController.value!,
      //   )
      // );
    }
  }

  _check() {
    // final form = CreateCarForm.parse(vin: _vinController.value.text);
    //
    // if(form.isInvalid) {
    //   for (var e in form.exceptions) {
    //     print(e);
    //     showErrorSnackBar(context, e.toString());
    //   }
    // }

    return true;
  }

  _listener(BuildContext context, CreateCarState state) {
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
        ProducerPickerWidget(
          label: 'Производитель',
          controller: _producerController,
          carModelController: _carModelController,
        ),
        SizedBox(height: 10),
        ValueListenableBuilder(
            valueListenable: _producerController,
            builder: (context, value, child) {
              if(value == null) return Container();
              return CarModelPickerWidget(
                label: 'Модель машины',
                producer: value,
                controller: _carModelController,
              );
            }
        ),
        SizedBox(height: 10),
        BlocConsumer<CreateCarCubit, CreateCarState>(
          listener: _listener,
          builder: (context, state) {
            if(state.status == FetchStatus.loading) {
              return ElevatedButtonWidget(
                  onPressed: () {},
                  child: CupertinoActivityIndicator()
              );
            }
            return MultiValueListenableBuilder(
                valuesListenable: [
                  _producerController,
                  _carModelController,
                ],
                builder: (context, value, child) {
                  bool isValid = value[0] != null
                      && value[1] != null;
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


