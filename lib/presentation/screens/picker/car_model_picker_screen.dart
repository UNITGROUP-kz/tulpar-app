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


@RoutePage<CarModelModel>()
class CarModelPickerScreen extends StatefulWidget {

  final ProducerModel producer;

  const CarModelPickerScreen({super.key, required this.producer});

  @override
  State<CarModelPickerScreen> createState() => _CarModelPickerScreenState();
}

class _CarModelPickerScreenState extends State<CarModelPickerScreen> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _refresh();
    _scrollController = ScrollController()..addListener(_listenerScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listenerScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future _refresh() async {
    return await context.read<CarModelCubit>().fetch(IndexCarModelParams(producer: widget.producer));
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final params = context.read<CarModelCubit>().state.params;
      await context.read<CarModelCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _back(CarModelModel carModel) => () {
    context.router.pop<CarModelModel>(carModel);
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      onRefresh: _refresh,
      scrollController: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        BlocBuilder<CarModelCubit, CarModelState>(
          builder: (context, state) {
            return Column(
              children: [
                ...state.carModels.map((carModel) {
                  return CarModelTile(carModel: carModel, callback: _back(carModel));
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
