import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/dictionary/city_model.dart';
import 'package:garage/presentation/routing/router.dart';

class CityController extends ValueNotifier<CityModel?> {
  CityController({ CityModel? value }): super(value);

  _change(CityModel city) {
    value = city;
    notifyListeners();
  }
}

class CityPickerWidget extends StatelessWidget {
  final CityController? controller;
  final String label;

  const CityPickerWidget({
    super.key,
    required this.label,
    this.controller
  });


  _toCityScreen(BuildContext context) => () async {
    context.router.push(const SplashRouter(
        children: [
          PickerRouter(
              children: [CityPickerRoute()]
          )
        ]
    )).then((value) {
      if(value != null) controller?._change(value as CityModel);

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
          onTap: _toCityScreen(context),
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
                  valueListenable: controller ?? CityController(),
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