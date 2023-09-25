import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/dictionary/producer_model.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/form/pickers/car_model_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/car_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/volume_picker.dart';
import 'package:garage/presentation/widgets/form/pickers/year_picker.dart';

class ProducerController extends ValueNotifier<ProducerModel?> {
  ProducerController({ ProducerModel? value }): super(value);

  _change(ProducerModel producer) {
    value = producer;
    notifyListeners();
  }
}

class ProducerPickerWidget extends StatelessWidget {
  final ProducerController? controller;
  final CarModelController? carModelController;
  final YearController? yearController;
  final VolumeController? volumeController;
  final CarApiController? carApiController;
  final String label;

  const ProducerPickerWidget({
    super.key,
    required this.label,
    this.controller,
    this.carModelController,
    this.yearController,
    this.volumeController,
    this.carApiController
  });


  void Function() _toProducerScreen(BuildContext context) => () {
    context.router.push(const SplashRouter(
      children: [
        PickerRouter(
            children: [ProducerPickerRoute()]
        )
      ]
    )).then((value) {
      if(value != null) {
        controller?._change(value as ProducerModel);
        if(carModelController != null) {
          print('Заебал');
          carModelController?.toCarModelScreen(
            context,
            value as ProducerModel,
            yearController,
            volumeController,
            carApiController
          );
        }
      }
    });
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 5),
        InkWell(
          onTap: _toProducerScreen(context),
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
                valueListenable: controller ?? ProducerController(),
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