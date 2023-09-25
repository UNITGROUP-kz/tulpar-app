import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/car_api_model.dart';

import '../../../data/models/dictionary/car_model.dart';
import '../../../data/models/dictionary/car_model_model.dart';
import '../../../data/models/dictionary/producer_model.dart';
import '../../../logic/bloc/dictionary/car_picker/car_picker_cubit.dart';
import '../../widgets/screen_templates/screen_default_template.dart';
import '../../widgets/tiles/car_tile.dart';


@RoutePage<CarApiModel>()
class CarPickerScreen extends StatefulWidget {
  final ProducerModel producer;
  final CarModelModel carModel;

  const CarPickerScreen({super.key, required this.producer, required this.carModel});

  @override
  State<CarPickerScreen> createState() => _CarPickerScreenState();
}

class _CarPickerScreenState extends State<CarPickerScreen> {

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh() async {
    return await context.read<CarPickerCubit>().fetch(
      producer: widget.producer,
      carModel: widget.carModel
    );
  }

  _back(CarApiModel car) => () {
    context.router.pop<CarApiModel>(car);
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      onRefresh: _refresh,
      padding: EdgeInsets.zero,
      children: [
        BlocBuilder<CarPickerCubit, CarPickerState>(
          builder: (context, state) {
            return Column(
              children: [
                ...state.cars.map((car) {
                  return CarTile(car: car, callback: _back(car));
                }).toList(),
                if(state.status == FetchStatus.loading) const Center(
                  child: CupertinoActivityIndicator(),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
