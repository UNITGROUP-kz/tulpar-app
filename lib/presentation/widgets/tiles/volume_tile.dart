
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/car_model_model.dart';

class VolumeTile extends StatelessWidget {
  final double volume;
  final VoidCallback? callback;

  const VolumeTile({super.key, required this.volume, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(volume.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }

}