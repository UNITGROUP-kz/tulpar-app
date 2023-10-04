import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/auth/store_model.dart';
import 'package:garage/data/repositories/dictionary/dictionary_repository.dart';
import 'package:garage/data/repositories/user/car_user_repository.dart';
import 'package:garage/logic/bloc/user/my_car/my_car_cubit.dart';
import 'package:garage/presentation/widgets/form/fields/text_field.dart';
import 'package:garage/presentation/widgets/navigation/header.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';
import 'package:garage/presentation/widgets/tiles/setting_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../data/models/dictionary/banner_model.dart';
import '../../../../data/models/dictionary/car_api_model.dart';
import '../../../../data/models/dictionary/car_vin_model.dart';
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

  final Future<List<BannerModel>> _banners = DictionaryRepository.indexBanner();

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
                      SizedBox(height: 10),
                      FutureBuilder<List<BannerModel>>(
                          future: _banners,
                          builder: (context, snapshot) {
                            print(snapshot);
                            if(snapshot.connectionState == ConnectionState.done) {
                              if((snapshot.data?.isEmpty ?? true) || snapshot.error != null) {
                                return Container();
                              }
                              return CarouselBanner(banners: snapshot.data!);
                            } return CupertinoActivityIndicator();
                          }
                      ),
                      SizedBox(height: 10),
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
      print(value);
      showModalBottomSheet(
          useSafeArea: true,
          useRootNavigator: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (context) => CarBottomSheet(cars: value)
      );
    }).catchError((value) {
      print(value);
      if(value is DioException) {
        showErrorSnackBar(context, value.response?.data['message'] ?? 'Неизвестная ошибка');
      } else {
        showErrorSnackBar(context, 'Неизвестная ошибка');
      }
    }).whenComplete(() {
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

  final List<CarVinModel> cars;

  const CarBottomSheet({super.key, required this.cars});

  _toDetails(BuildContext context, CarVinModel car) => () async {
    context.router.pop().then((value) async {
      context.router.pop().then((value) {
        context.router.navigate(SplashRouter(
            children: [
              UserRouter(
                  children: [
                    UserCarRouter(
                        children: [
                          DetailsCarRoute(carVin: car)
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
          Text('Выберите машину', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
          SizedBox(height: 20,),
          Column(
            children: cars.map((e) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CarCard(carVin: e, callback: _toDetails(context, e),),
                  SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}

class CarouselBanner extends StatefulWidget {
  final List<BannerModel> banners;

  const CarouselBanner({super.key, required this.banners});

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  late CarouselController _carouselController;
  int indexCurrent = 0;

  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  _changePage(BannerModel banner) => () {
    int value = widget.banners.indexWhere((element) => element.id == banner.id);
    _setIndex(value);
    _carouselController.animateToPage(value);
  };

  _setIndex(int value) {
    if(value == -1) return;
    setState(() {
      indexCurrent = value;
    });
  }

  toStore(StoreModel store) => () {
    context.router.navigate(SplashRouter(
        children: [
          UserRouter(
              children: [
                UserOrderRouter(
                    children: [
                      StoreRoute(store: store)
                    ]
                )
              ]
          )
        ]
    ));
  };


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CarouselSlider(
            carouselController: _carouselController,
            items: widget.banners.map((e) {
              return GestureDetector(
                onTap: toStore(e.store),
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child: CachedNetworkImage(
                    imageUrl: e.image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: false,
                aspectRatio: 16 / 7.5
            )
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.banners.map((e) {
                      return GestureDetector(
                        onTap: _changePage(e),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(
                                  e.id == widget.banners[indexCurrent].id? 1: 0.5
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      );
                    }).toList()
                )
            )
        )
      ],
    );
  }
}