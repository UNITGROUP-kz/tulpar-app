import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/logic/bloc/user/details_car/details_car_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/tiles/part_model.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/car_model.dart';
import '../../../widgets/snackbars/error_snackbar.dart';

@RoutePage()
class DetailsCarScreen extends StatefulWidget {
  final CarModel car;

  const DetailsCarScreen({super.key, required this.car});

  @override
  State<DetailsCarScreen> createState() => _DetailsCarScreenState();
}

class _DetailsCarScreenState extends State<DetailsCarScreen> {
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;


  @override
  void initState() {
    _onRefresh();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController()..addListener(_listenerScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listenerScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future _onRefresh() async {
    return await context.read<DetailsCarCubit>().fetch();
  }

  _listenerState(context, DetailsCarState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final params = context.read<DetailsCarCubit>().state.params;
      await context.read<DetailsCarCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _toOrder(PartModel part) => () {
    context.router.navigate(SplashRouter(
      children: [
        UserFormRouter(
          children: [
            CreateOrderRoute(part: part, car: widget.car)
          ]
        )
      ]
    ));
  };

  _back() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScreenDefaultTemplate(
            scrollController: _scrollController,
            onRefresh: _onRefresh,
            children: [
              TextField(controller: _textEditingController),
              BlocConsumer<DetailsCarCubit, DetailsCarState>(
                listener: _listenerState,
                builder: (context, state) {
                  return Column(
                    children: [
                      ...state.parts.map((e) {
                        return PartTile(part: e, callback: _toOrder(e));
                      }).toList(),
                      if(state.status == FetchStatus.loading) CupertinoActivityIndicator(),
                      if(state.status == FetchStatus.error) Text('Ошибка'),
                    ],
                  );
                },
              )
            ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: IconButton(onPressed: _back, icon: Icon(Icons.arrow_back_ios)),
        ),

      ],
    );
  }
}
