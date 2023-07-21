import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/core/services/fb_auth_service.dart';
import 'package:garage/core/services/fb_service.dart';
import 'package:garage/firebase_options.dart';
import 'package:garage/logic/bloc/dictionary/car_model/car_model_cubit.dart';
import 'package:garage/logic/bloc/dictionary/current_city/current_city_cubit.dart';
import 'package:garage/logic/bloc/dictionary/producer/producer_cubit.dart';
import 'package:garage/logic/bloc/user/create_car/create_car_cubit.dart';
import 'package:garage/logic/bloc/user/create_order/create_order_cubit.dart';
import 'package:garage/logic/bloc/user/details_car/details_car_cubit.dart';
import 'package:garage/logic/bloc/user/my_car/my_car_cubit.dart';
import 'package:garage/logic/bloc/user/my_orders/my_order_cubit.dart';
import 'package:garage/logic/bloc/user/order_offer/order_offer_cubit.dart';
import 'package:garage/logic/bloc/user/register/register_cubit.dart';
import 'package:garage/presentation/routing/router.dart';

import 'core/services/isar_service.dart';
import 'logic/bloc/user/auth/auth_cubit.dart';

// bool shouldUseFirebaseEmulator = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await FBService.initialize();
  FBAuthService.setInstance();
  ApiService.initialize();
  await IsarService.initialize();

  // if (shouldUseFirebaseEmulator) {
  //   await auth.useAuthEmulator('localhost', 9099);
  // }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthCubit authCubit;
  late MyCarCubit myCarCubit;
  late MyOrderCubit myOrderCubit;
  late AppRouter _appRouter;

  @override
  void initState() {
    authCubit = AuthCubit()..initial();
    myCarCubit = MyCarCubit();
    myOrderCubit = MyOrderCubit();
    _appRouter = AppRouter(authCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => authCubit,
        ),
        BlocProvider(
          create: (context) => RegisterCubit(authCubit),
        ),
        BlocProvider(
          create: (context) => myCarCubit,
        ),
        BlocProvider(
          create: (context) => myOrderCubit,
        ),
        BlocProvider(
          create: (context) => OrderOfferCubit(),
        ),
        BlocProvider(
          create: (context) => DetailsCarCubit(),
        ),
        BlocProvider(
          create: (context) => ProducerCubit(),
        ),
        BlocProvider(
          create: (context) => CarModelCubit(),
        ),
        BlocProvider(
          create: (context) => CurrentCityCubit()..initial(),
        ),
        BlocProvider(
          create: (context) => CreateCarCubit(myCarCubit),
        ),
        BlocProvider(
          create: (context) => CreateOrderCubit(myOrderCubit),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
