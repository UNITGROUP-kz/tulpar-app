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
  late TextEditingController _vinController;
  late ProducerController _producerController;
  late CarModelController _carModelController;
  late VolumeController _volumeController;
  late YearController _yearController;

  @override
  void initState() {
    _vinController = TextEditingController();
    _producerController = ProducerController()..addListener(_listenerProducer);
    _carModelController = CarModelController();
    _volumeController = VolumeController();
    _yearController = YearController();
    super.initState();
  }

  _listenerProducer() {
    _carModelController.remove();
  }

  @override
  void dispose() {
    _vinController.dispose();
    _producerController.removeListener(_listenerProducer);
    _producerController.dispose();
    _carModelController.dispose();
    _volumeController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  _create() {
    if(_check()) {
      context.read<CreateCarCubit>().create(CreateCarParams(
          model: _carModelController.value!,
          producer: _producerController.value!,
          vinNumber: _vinController.value.text,
          volume: _volumeController.value!,
          engineVolume: _volumeController.value!,
          year: _yearController.value!.year
        )
      );
    }
  }

  _check() {
    final form = CreateCarForm.parse(vin: _vinController.value.text);

    if(form.isInvalid) {
      for (var e in form.exceptions) {
        print(e);
        showErrorSnackBar(context, e.toString());
      }
    }
    
    return form.isValid;
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
        TextFieldWidget(
            isRequired: true,
            label: 'VIN-код',
            controller: _vinController
        ),
        const SizedBox(height: 10),
        ProducerCarModelPicker(
          producerController: _producerController,
          carModelController: _carModelController,
          yearController: _yearController,
          volumeController: _volumeController,
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder(
            valueListenable: _carModelController,
            builder: (context, value, child) {
              if(value == null) return Container();
              return YearPickerWidget(
                  label: 'Год машины',
                  controller: _yearController,
                  volumeController: _volumeController,
              );
            }
        ),
        ValueListenableBuilder(
            valueListenable: _yearController,
            builder: (context, value, child) {
              if(value == null) return Container();
              return VolumePickerWidget(label: 'Объем бака', controller: _volumeController);
            }
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
                  _vinController,
                  _producerController,
                  _carModelController,
                  _yearController,
                  _volumeController
                ],
                builder: (context, value, child) {
                  bool isValid = value[0].text.isNotEmpty
                      && value[1] != null
                      && value[2] != null
                      && value[3] != null
                      && value[4] != null;
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


