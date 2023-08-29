
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/car_model_model.dart';

class YearTile extends StatelessWidget {
  final DateTime year;
  final VoidCallback? callback;

  const YearTile({super.key, required this.year, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(year.year.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }

}