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
import '../../widgets/tiles/volume_tile.dart';


@RoutePage<double>()
class VolumePickerScreen extends StatefulWidget {


  const VolumePickerScreen({super.key});

  @override
  State<VolumePickerScreen> createState() => _VolumePickerScreenState();
}

class _VolumePickerScreenState extends State<VolumePickerScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  _back(double volume) => () {
    context.router.pop<double>(volume);
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      padding: EdgeInsets.zero,
      children: [
        Column(
          children: [
            ...List.generate(99, (index) => index).map((volume) {
              final value = double.parse((0.1 * volume + 1).toStringAsFixed(1));
              return VolumeTile(volume: value, callback: _back(value));
            }).toList(),
          ],
        )
      ],
    );
  }
}
