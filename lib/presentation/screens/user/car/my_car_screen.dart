import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/repositories/user/car_user_repository.dart';
import 'package:garage/logic/bloc/user/my_car/my_car_cubit.dart';
import 'package:garage/presentation/widgets/form/fields/text_field.dart';
import 'package:garage/presentation/widgets/navigation/header.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:garage/presentation/widgets/tiles/setting_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../data/models/dictionary/car_api_model.dart';
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

  _toDetails(CarApiModel car) => () {
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

  _toCustom() {
    context.router.navigate(const SplashRouter(
        children: [
          UserRouter(
              children: [
                UserCarRouter(
                    children: [
                      CustomCarRoute()
                    ]
                )
              ]
          )
        ]
    ));
  }

  _showVin() {
    showModalBottomSheet(
        useSafeArea: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) => VinBottomSheet()
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      onRefresh: _onRefresh,
      padding: EdgeInsets.zero,
      scrollController: _scrollController,
      children: [
        BlocConsumer<MyCarCubit, MyCarState>(
          listener: _listenerState,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Header(isBack: false, title: 'Гараж'),
                      SettingsTile(
                          label: 'Искать запчасти в ручную',
                          icon: Icons.handyman,
                          callback: _toCustom,
                      ),
                      SettingsTile(
                        label: 'Искать запчасти по VIN',
                        icon: Icons.car_rental,
                        backgroundIcon: Colors.blue,
                        callback: _showVin,
                      ),
                      SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          child: ElevatedButtonWidget(
                              onPressed: _addCar,
                              child: Text('Добавить машину')
                          )
                      ),
                    ],
                  )
                ),
                if(state.status == FetchStatus.success) CarouselSlider(
                  options: CarouselOptions(
                      // height: 400.0
                      // height: double.maxFinite,
                    aspectRatio : 16 / 7,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeFactor: 0.2
                  ),
                  items: state.cars.map((car) {
                    return CarCard(
                      car: car.car,
                      callback: _toDetails(car.car),
                      isMy: true,
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      // if(state.status == FetchStatus.success) ...state.cars.map((car) {
                      //   return CarCard(car: car, callback: _toDetails(car));
                      // }).toList(),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            if(state.cars.isEmpty && state.status == FetchStatus.success) Text('У вас нет Машин'),
                            if(state.status == FetchStatus.error) Text('Неизвестная ошибка'),
                            if(state.status == FetchStatus.loading) CupertinoActivityIndicator(),

                          ],
                        ),
                      )

                    ],
                  ),
                )

              ]
            );
          },
        ),


      ],
    );
  }
}


class VinBottomSheet extends StatefulWidget {
  @override
  State<VinBottomSheet> createState() => _VinBottomSheetState();
}

class _VinBottomSheetState extends State<VinBottomSheet> {
  late TextEditingController _textEditingController;
  bool isLoading = false;

  _showCar(BuildContext context) => () {
    setState(() {
      isLoading = false;
    });
    CarUserRepository.getByVIN(_textEditingController.value.text).then((value) {
      showModalBottomSheet(
          useSafeArea: true,
          useRootNavigator: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (context) => CarBottomSheet(car: value)
      );
      setState(() {
        isLoading = false;
      });
    }).catchError((value) {
      if(value is DioException) {
        showErrorSnackBar(context, value.response?.data['message'] ?? 'Неизвестная ошибка');
      } else {
        showErrorSnackBar(context, 'Неизвестная ошибка');
      }
      setState(() {
        isLoading = false;
      });
    });

  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldWidget(label: 'VIN-code', controller: _textEditingController),
          SizedBox(height: 20,),
          ElevatedButtonWidget(
              onPressed: _showCar(context),
              child: !isLoading ? Text('Искать машину')
                  : CircularProgressIndicator(color: Colors.black,)
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}


class CarBottomSheet extends StatelessWidget {

  final CarApiModel car;

  const CarBottomSheet({super.key, required this.car});

  _toDetails(BuildContext context) => () async {
    context.router.pop().then((value) async {
      context.router.pop().then((value) {
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
      });
    });
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Это ваша машина?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
          SizedBox(height: 20,),
          CarCard(car: car),
          SizedBox(height: 20,),
          ElevatedButtonWidget(child: Text('Подтвердить'), onPressed: _toDetails(context),)
        ],
      ),
    );
  }

}