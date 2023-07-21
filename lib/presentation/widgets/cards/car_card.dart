
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/car_model.dart';
import '../../routing/router.dart';

class CarCard extends StatelessWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});


  _toDetails(BuildContext context) => () {
    context.router.navigate(SplashRouter(
      children: [
        UserRouter(
          children: [
            UserCarRouter(
              children: [
                DetailsCarRoute(car: car)
              ]
            )
          ]
        )
      ]
    ));
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toDetails(context),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)
        ),
        width: double.infinity,
        child: Column(
          children: [
            Text(car.name),
            Text(car.modelName),
            Text(car.vinNumber)
          ],
        ),
      ),
    );
  }

}