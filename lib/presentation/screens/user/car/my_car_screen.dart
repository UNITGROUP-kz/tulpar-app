import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/logic/bloc/user/my_car/my_car_cubit.dart';
import 'package:garage/presentation/widgets/navigation/header.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../../data/models/dictionary/car_model.dart';
import '../../../routing/router.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/cards/car_card.dart';

@RoutePage()
class MyCarScreen extends StatefulWidget {

  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {
  late ScrollController _scrollController;


  @override
  void initState() {
    context.read<MyCarCubit>().fetch();
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
    return await context.read<MyCarCubit>().fetch();
  }

  _listenerState(context, MyCarState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final state = context.read<MyCarCubit>().state;

      if(state.status != FetchStatus.loading) return;

      final params = context.read<MyCarCubit>().state.params;
      await context.read<MyCarCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _addCar() {
    context.router.navigate(const SplashRouter(
      children: [
        UserFormRouter(
            children: [
              CreateCarRoute()
            ]
        )
      ]
    ));
  }

  _toDetails(CarModel car) => () {
    context.router.navigate(SplashRouter(
        children: [
          UserRouter(
              children: [
                UserCarRouter(
                    children: [
                      DetailsCarRoute(car: car)
                    ]
                )
              ]
          )
        ]
    ));
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      onRefresh: _onRefresh,
      scrollController: _scrollController,
      children: [
        BlocConsumer<MyCarCubit, MyCarState>(
          listener: _listenerState,
          builder: (context, state) {
            return Column(
              children: [
                Header(isBack: false, title: 'Гараж'),
                if(state.status == FetchStatus.loading) CupertinoActivityIndicator(),
                if(state.status == FetchStatus.error) Text('Ошибка'),
                ...state.cars.map((car) {
                  return CarCard(car: car, callback: _toDetails(car));
                }).toList(),
                if(state.cars.isEmpty && state.status == FetchStatus.success) Text('Нет Машин'),

                if(state.status == FetchStatus.success) Container(
                    width: double.infinity,
                    child: ElevatedButtonWidget(
                        onPressed: _addCar,
                        child: Text('Добавить машину')
                    )
                ),
              ]
            );
          },
        ),


      ],
    );
  }
}
