import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../../data/models/dictionary/producer_model.dart';

class VolumeController extends ValueNotifier<double?> {
  VolumeController({ double? value }): super(value);

  _change(double volume) {
    value = volume;
    notifyListeners();
  }

  void toVolumeScreen(BuildContext context) {
    context.router.push(const SplashRouter(
        children: [
          PickerRouter(
              children: [VolumePickerRoute()]
          )
        ]
    )).then((value) {
      if(value != null) _change(value as double);
    });
  }

  remove() {
    value = null;
    notifyListeners();
  }
}

class VolumePickerWidget extends StatelessWidget {
  final VolumeController? controller;
  final String label;

  const VolumePickerWidget({
    super.key,
    required this.label,
    this.controller,
  });

  _onTap(BuildContext context) => () {
    controller?.toVolumeScreen(context);
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
                  valueListenable: controller ?? VolumeController(),
                  builder: (context, value, child) {
                    return Text(
                        (value ?? 'Не выбрано').toString()
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