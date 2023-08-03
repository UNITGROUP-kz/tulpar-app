
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/widgets/tiles/data_tile.dart';

import '../../../data/models/dictionary/car_model.dart';
import '../../routing/router.dart';

class CarCard extends StatelessWidget {
  final VoidCallback? callback;
  final CarModel car;

  const CarCard({super.key, required this.car, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: callback,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)
          ),
          width: double.infinity,
          child: Column(
            children: [
              DataTile(title: 'Машина', data: car.name, isDivider: false),
              DataTile(title: 'VIN', data: car.vinNumber, isDivider: false)
            ],
          ),
        ),
      ),
    );
  }

}