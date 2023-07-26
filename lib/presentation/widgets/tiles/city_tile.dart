
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/city_model.dart';

class CityTile extends StatelessWidget {
  final CityModel city;
  final VoidCallback? callback;

  const CityTile({super.key, required this.city, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(city.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }

}