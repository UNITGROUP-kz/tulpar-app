import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/form/pickers/volume_picker.dart';

import '../../../../data/models/dictionary/producer_model.dart';

class YearController extends ValueNotifier<DateTime?> {
  YearController({ DateTime? value }): super(value);

  _change(DateTime year) {
    value = year;
    notifyListeners();
  }

  void toYearScreen(BuildContext context, VolumeController? volume) {
    context.router.push(const SplashRouter(
        children: [
          PickerRouter(
              children: [YearPickerRoute()]
          )
        ]
    )).then((value) {
      if(value != null) {
        _change(value as DateTime);
        if(volume != null) {
          volume.toVolumeScreen(context);
        }
      }
    });
  }

  remove() {
    value = null;
    notifyListeners();
  }
}

class YearPickerWidget extends StatelessWidget {
  final YearController? controller;
  final VolumeController? volumeController;
  final String label;

  const YearPickerWidget({
    super.key,
    required this.label,
    this.controller,
    this.volumeController,
  });

  _onTap(BuildContext context) => () {
    controller?.toYearScreen(context, volumeController);
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
                  valueListenable: controller ?? YearController(),
                  builder: (context, value, child) {
                    return Text(
                        (value?.year ?? 'Не выбрано').toString()
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