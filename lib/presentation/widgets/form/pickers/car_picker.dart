import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/form/pickers/volume_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/year_picker.dart';

import '../../../../data/models/dictionary/car_api_model.dart';
import '../../../../data/models/dictionary/producer_model.dart';

class CarApiController extends ValueNotifier<CarApiModel?> {
  CarApiController({ CarApiModel? value }): super(value);

  _change(CarApiModel carModel) {
    value = carModel;
    notifyListeners();
  }

  void toCarApiScreen(
      BuildContext context,
      ProducerModel producer,
      CarModelModel carModel,
      YearController? yearController,
      VolumeController? volumeController
      ) {
    print('CAR Picker Route');
    context.router.push(SplashRouter(
        children: [
          PickerRouter(
              children: [CarPickerRoute(carModel: carModel, producer: producer)]
          )
        ]
    )).then((value) {
      if(value != null) {
        _change(value as CarApiModel);
        if(yearController != null) {
          yearController.toYearScreen(
              context,
              volumeController
          );
        }
      }
    });
  }

  remove() {
    value = null;
    notifyListeners();
  }
}

class CarApiPickerWidget extends StatelessWidget {
  final CarApiController? controller;
  final YearController? yearController;
  final VolumeController? volumeController;
  final ProducerModel producer;
  final CarModelModel carModel;
  final String label;

  const CarApiPickerWidget({
    super.key,
    required this.label,
    this.controller,

    required this.producer,
    required this.carModel,

    this.yearController,
    this.volumeController,
  });


  _onTap(BuildContext context) => () {
    print('aaa');
    controller?.toCarApiScreen(context, producer, carModel, yearController, volumeController);
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 5),
        InkWell(
          onTap: _onTap(context),
          child: Container(
            height: 55,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(10)

            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ValueListenableBuilder(
                  valueListenable: controller ?? CarApiController(),
                  builder: (context, value, child) {
                    return Text(
                        value?.name ?? 'Не выбрано'
                    );
                  }
              ),
            ),
          ),
        ),
      ],
    );
  }
}