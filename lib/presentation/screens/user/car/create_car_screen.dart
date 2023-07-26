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
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../widgets/buttons/elevated_button.dart';
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

  @override
  void initState() {
    _vinController = TextEditingController();
    _producerController = ProducerController()..addListener(_listenerProducer);
    _carModelController = CarModelController();
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
    super.dispose();
  }

  _create() {
    if(_check()) {
      context.read<CreateCarCubit>().create(CreateCarParams(
          model: _carModelController.value!,
          producer: _producerController.value!,
          vinNumber: _vinController.value.text
        )
      );
    }
  }

  _check() {
    final form = CreateCarForm.parse(vin: _vinController.value.text);

    if(form.isInvalid) {
      for (var e in form.exceptions) {
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
        Header(title: 'Создать машину'),
        TextFieldWidget(
            isRequired: true,
            label: 'VIN-code',
            controller: _vinController
        ),
        SizedBox(height: 10),
        ProducerPickerWidget(label: 'Producer', controller: _producerController),
        SizedBox(height: 10),
        ValueListenableBuilder(
            valueListenable: _producerController,
            builder: (context, value, child) {
              if(value == null) return Container();
              return CarModelPickerWidget(label: 'Car model', producer: value, controller: _carModelController);
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
                  _vinController,
                  _producerController,
                  _carModelController
                ],
                builder: (context, value, child) {
                  return ElevatedButtonWidget(
                      onPressed: value[0].text.isNotEmpty && value[1] != null
                          && value[2] != null ? _create : null,
                      child: Text('create')
                  );
                }
            );
          },
        )


      ],
    );
  }
}


