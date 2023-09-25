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
import 'package:garage/presentation/widgets/form/pickers/car_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/volume_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/year_picker.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/form/pickers/producer_car_model_picker.dart';
import '../../../widgets/form/pickers/producer_picker.dart';
import '../../../widgets/navigation/header.dart';

@RoutePage()
class CreateCarScreen extends StatefulWidget {
  @override
  State<CreateCarScreen> createState() => _CreateCarScreenState();
}

class _CreateCarScreenState extends State<CreateCarScreen> {
  late ProducerController _producerController;
  late CarModelController _carModelController;
  late CarApiController _carApiController;


  @override
  void initState() {
    _producerController = ProducerController()..addListener(_listenerProducer);
    _carModelController = CarModelController()..addListener(_listenerCarModel);
    _carApiController = CarApiController();
    super.initState();
  }

  _listenerProducer() {
    _carModelController.remove();
    _carApiController.remove();
  }

  _listenerCarModel() {
    _carApiController.remove();
  }

  @override
  void dispose() {
    _producerController.removeListener(_listenerProducer);
    _carModelController.removeListener(_listenerCarModel);
    _producerController.dispose();
    _carModelController.dispose();
    _carApiController.dispose();
    super.dispose();
  }

  _create() {
    if(_check()) {
      context.read<CreateCarCubit>().create(CreateCarParams(
          model: _carModelController.value!,
          producer: _producerController.value!,
          carApi: _carApiController.value!
        )
      );
    }
  }

  _check() {
    return true;
  }

  _listener(BuildContext context, CreateCarState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    } else if(state.status == FetchStatus.success) {
      context.router.pop();
    }
  }

  _back() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        const Header(title: 'Создать машину', isBack: true),
        const SizedBox(height: 10),
        ProducerCarModelPicker(
          producerController: _producerController,
          carModelController: _carModelController,
          carApiController: _carApiController,
        ),
        const SizedBox(height: 10),
        BlocConsumer<CreateCarCubit, CreateCarState>(
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
                  _producerController,
                  _carModelController,
                  _carApiController
                ],
                builder: (context, value, child) {
                  bool isValid = value[0] != null
                      && value[1] != null
                      && value[2] != null;
                  return ElevatedButtonWidget(
                      onPressed: isValid ? _create : null,
                      child: const Text('Cоздать машину')
                  );
                }
            );
          },
        )


      ],
    );
  }
}


