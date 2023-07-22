import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/fform/forms/create_car_form.dart';
import 'package:garage/data/params/car/create_car_params.dart';
import 'package:garage/logic/bloc/user/create_car/create_car_cubit.dart';
import 'package:garage/presentation/widgets/builder/multi_value_listenable_builder.dart';
import 'package:garage/presentation/widgets/form/fields/car_model_picker.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../widgets/form/fields/producer_picker.dart';

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
    return Stack(
      children: [
        ScreenDefaultTemplate(
          children: [
            TextField(controller: _vinController),
            ProducerPickerWidget(label: 'Producer', controller: _producerController),
            ValueListenableBuilder(
                valueListenable: _producerController,
                builder: (context, value, child) {
                  if(value == null) return Container();

                  return CarModelPickerWidget(label: 'Car model', producer: value, controller: _carModelController);
                }
            ),
            BlocConsumer<CreateCarCubit, CreateCarState>(
              listener: _listener,
              builder: (context, state) {
                if(state.status == FetchStatus.loading) {
                  return ElevatedButton(
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
                      print(value);
                      return ElevatedButton(
                          onPressed: value[0].text.isNotEmpty && value[1] != null
                              && value[2] != null ? _create : null,
                          child: Text('create')
                      );
                    }
                );
              },
            )


          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: IconButton(onPressed: _back, icon: Icon(Icons.arrow_back_ios)),
        ),
      ],
    );
  }
}


