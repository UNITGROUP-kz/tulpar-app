import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:garage/presentation/routing/guards/auth_guard.dart';
import 'package:garage/presentation/screens/auth/login_screen.dart';
import 'package:garage/presentation/screens/shop/store_splash_screen.dart';
import 'package:garage/presentation/screens/splash_screen.dart';
import 'package:garage/presentation/screens/user/car/create_car_screen.dart';
import 'package:garage/presentation/screens/user/car/my_car_screen.dart';
import 'package:garage/presentation/screens/user/order/create_order_screen.dart';
import 'package:garage/presentation/screens/user/order/details_order_screen.dart';
import 'package:garage/presentation/screens/user/order/orders_screen.dart';
import 'package:garage/presentation/screens/user/user_splash_screen.dart';


part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashRouter.page,
      path: '/',
      children: [
        AutoRoute(
            path: '',
            page: UserRouter.page,
            children: [
              AutoRoute(
                page: UserCarRouter.page,
                path: '',
                children:  [
                  AutoRoute(
                    initial: true,
                    path: '',
                    page: MyCarRoute.page,
                  ),
                ]
              ),
              AutoRoute(
                page: UserOrderRouter.page,
                path: 'order',
                children: [
                  AutoRoute(
                    path: '',
                    page: OrdersRoute.page,
                  ),
                  AutoRoute(
                    page: DetailsOrderRoute.page,
                  ),
                ]
              )
            ],
            guards: [AuthGuard(), UserGuard()]
        ),
        AutoRoute(
          page: UserFormRouter.page,
          path: 'user-form',
          children: [
            AutoRoute(
              page: CreateCarRoute.page,
            ),
            AutoRoute(
              page: CreateOrderRoute.page,
            ),
          ],
          guards: [AuthGuard(), UserGuard()]
        ),
        // AutoRoute(
        //     path: 'store',
        //     page: StoreRouter.page,
        //     children: [
        //
        //     ]
        // )
      ]
    ),
    AutoRoute(page: LoginRoute.page)
  ];
}

@RoutePage(name: 'UserOrderRouter')
class UserOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}

@RoutePage(name: 'UserCarRouter')
class UserCarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}

@RoutePage(name: 'UserFormRouter')
class UserFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}