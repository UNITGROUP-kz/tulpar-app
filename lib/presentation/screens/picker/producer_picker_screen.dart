import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/producer_model.dart';

import '../../../logic/bloc/dictionary/producer/producer_cubit.dart';
import '../../widgets/form/fields/text_field.dart';
import '../../widgets/screen_templates/screen_default_template.dart';
import '../../widgets/tiles/producer_tile.dart';


@RoutePage<ProducerModel>()
class ProducerPickerScreen extends StatefulWidget {
  @override
  State<ProducerPickerScreen> createState() => _ProducerPickerScreenState();
}

class _ProducerPickerScreenState extends State<ProducerPickerScreen> {
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
    return await context.read<ProducerCubit>().fetch();
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final params = context.read<ProducerCubit>().state.params;
      await context.read<ProducerCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _back(ProducerModel producer) => () {
    context.router.pop<ProducerModel>(producer);
  };

  _onFilter(String text) async {
    final params = context.read<ProducerCubit>().state.params;
    await context.read<ProducerCubit>().fetch(params?.copyWith(
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
        BlocBuilder<ProducerCubit, ProducerState>(
          builder: (context, state) {
            return Column(
              children: [
                ...state.producers.map((producer) {
                  return ProducerTile(producer: producer, callback: _back(producer));
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
