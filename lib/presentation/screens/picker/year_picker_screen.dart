import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/producer_model.dart';

import '../../../data/models/dictionary/car_model_model.dart';
import '../../../data/params/dictionary/index_car_model_params.dart';
import '../../../logic/bloc/dictionary/car_model/car_model_cubit.dart';
import '../../widgets/screen_templates/screen_default_template.dart';
import '../../widgets/tiles/car_model_tile.dart';
import '../../widgets/tiles/year_tile.dart';


@RoutePage<DateTime>()
class YearPickerScreen extends StatefulWidget {


  const YearPickerScreen({super.key});

  @override
  State<YearPickerScreen> createState() => _YearPickerScreenState();
}

class _YearPickerScreenState extends State<YearPickerScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  _back(DateTime year) => () {
    context.router.pop<DateTime>(year);
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      padding: EdgeInsets.zero,
      children: [
        Column(
          children: [
            ...List.generate(40, (index) => index).map((year) {
              final date = DateTime.now().subtract(Duration(days: 365 * year));
              return YearTile(year: date, callback: _back(date));
            }).toList(),
          ],
        )
      ],
    );
  }
}
