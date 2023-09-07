import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/logic/bloc/dictionary/current_city/current_city_cubit.dart';

import '../../../data/models/dictionary/city_model.dart';
import '../../widgets/form/fields/text_field.dart';
import '../../widgets/screen_templates/screen_default_template.dart';
import '../../widgets/tiles/city_tile.dart';


@RoutePage<CityModel>()
class CityPickerScreen extends StatefulWidget {
  @override
  State<CityPickerScreen> createState() => _CityPickerScreenState();
}

class _CityPickerScreenState extends State<CityPickerScreen> {
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
    return await context.read<CurrentCityCubit>().fetch();
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final params = context.read<CurrentCityCubit>().state.params;
      await context.read<CurrentCityCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _back(CityModel city) => () {
    context.router.pop<CityModel>(city);
  };

  _onFilter(String text) async {
    final params = context.read<CurrentCityCubit>().state.params;
    await context.read<CurrentCityCubit>().fetch(params?.copyWith(
        filter: text,
        startRow: 0
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      onRefresh: _refresh,
      scrollController: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        Padding(
            padding: EdgeInsets.all(20),
            child: TextFieldWidget(icon: Icon(Icons.search), onSubmit: _onFilter,)
        ),
        BlocBuilder<CurrentCityCubit, CurrentCityState>(
          builder: (context, state) {
            return Column(
              children: [
                ...state.cities.map((city) {
                  return CityTile(city: city, callback: _back(city));
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
