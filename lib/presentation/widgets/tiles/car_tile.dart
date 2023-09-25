

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/car_api_model.dart';
import '../../../data/models/dictionary/car_model.dart';
import '../../../data/models/dictionary/car_model_model.dart';

class CarTile extends StatelessWidget {
  final CarApiModel car;
  final VoidCallback? callback;

  const CarTile({super.key, required this.car, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  // if(car.image != null) ...[
                  //   ClipRRect(
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: CachedNetworkImage(
                  //       imageUrl: car.image!,
                  //       height: 75,
                  //     ),
                  //   ),
                  //   SizedBox(width: 10)
                  // ],
                  Expanded(
                      child: Text(car.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                      )
                  ),
                ],
              )
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }

}