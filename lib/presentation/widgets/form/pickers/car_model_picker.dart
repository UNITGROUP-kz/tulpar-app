import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../../data/models/dictionary/producer_model.dart';

class CarModelController extends ValueNotifier<CarModelModel?> {
  CarModelController({ CarModelModel? value }): super(value);

  _change(CarModelModel carModel) {
    value = carModel;
    notifyListeners();
  }

  remove() {
    value = null;
    notifyListeners();
  }
}

class CarModelPickerWidget extends StatelessWidget {
  final CarModelController? controller;
  final ProducerModel producer;
  final String label;

  const CarModelPickerWidget({
    super.key,
    required this.label,
    this.controller,
    required this.producer
  });


  _toCarModelScreen(BuildContext context) => () async {
    context.router.push(SplashRouter(
        children: [
          PickerRouter(
              children: [CarModelPickerRoute(producer: producer)]
          )
        ]
    )).then((value) {
      if(value != null) controller?._change(value as CarModelModel);
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
          onTap: _toCarModelScreen(context),
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
                  valueListenable: controller ?? CarModelController(),
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