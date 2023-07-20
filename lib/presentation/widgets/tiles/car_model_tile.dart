
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/car_model_model.dart';

class CarModelTile extends StatelessWidget {
  final CarModelModel carModel;
  final VoidCallback? callback;

  const CarModelTile({super.key, required this.carModel, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(carModel.name)
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }

}