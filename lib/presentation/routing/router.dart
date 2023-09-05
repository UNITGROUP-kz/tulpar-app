import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/guards/auth_guard.dart';
import 'package:garage/presentation/screens/splash_screen.dart';
import 'package:garage/presentation/screens/store/offers/my_offers_screen.dart';
import 'package:garage/presentation/screens/store/order/details_order_screen.dart';
import 'package:garage/presentation/screens/user/car/create_car_screen.dart';
import 'package:garage/presentation/screens/user/car/my_car_screen.dart';
import 'package:garage/presentation/screens/user/offer/details_offer_screen.dart';
import 'package:garage/presentation/screens/user/order/create_order_screen.dart';
import 'package:garage/presentation/screens/user/order/details_order_screen.dart';
import 'package:garage/presentation/screens/user/order/orders_screen.dart';
import 'package:garage/presentation/screens/user/profile/profile_screen.dart';
import 'package:garage/presentation/screens/user/user_splash_screen.dart';

import '../../data/models/auth/store_model.dart';
import '../../data/models/dictionary/car_model.dart';
import '../../data/models/dictionary/car_model_model.dart';
import '../../data/models/dictionary/city_model.dart';
import '../../data/models/dictionary/offer_model.dart';
import '../../data/models/dictionary/order_model.dart';
import '../../data/models/dictionary/part_model.dart';
import '../../data/models/dictionary/producer_model.dart';
import '../../logic/bloc/store/auth/auth_store_cubit.dart';
import '../screens/documents/contract_offer_screen.dart';
import '../screens/documents/documents_screen.dart';
import '../screens/documents/privacy_screen.dart';
import '../screens/picker/car_model_picker_screen.dart';
import '../screens/picker/city_picker_screen.dart';
import '../screens/picker/producer_picker_screen.dart';
import '../screens/picker/volume_picker_screen.dart';
import '../screens/picker/year_picker_screen.dart';
import '../screens/store/auth/login_screen.dart';
import '../screens/store/offers/create_offer_screen.dart';
import '../screens/store/order/order_screen.dart';
import '../screens/store/profile/change_categories_screen.dart';
import '../screens/store/profile/profile_screen.dart';
import '../screens/store/profile/change_store_screen.dart';
import '../screens/store/store_splash_screen.dart';
import '../screens/user/auth/login_screen.dart';
import '../screens/user/auth/register_screen.dart';
import '../screens/user/car/details_car_screen.dart';
import '../screens/user/offer/offers_screen.dart';
import '../screens/user/order/rate_order_screen.dart';
import '../screens/user/profile/change_profile.dart';
import '../screens/user/profile/support_screen.dart';
import '../screens/user/store_screen.dart';


part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthCubit authCubit;
  final AuthStoreCubit authStoreCubit;


  AppRouter(this.authCubit, this.authStoreCubit);


  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRouter.page, path: '/',
      children: [
        AutoRoute(path: '', page: UserRouter.page,
            children: [
              AutoRoute(page: UserCarRouter.page, path: '',
                children:  [
                  AutoRoute(initial: true, path: '', page: MyCarRoute.page),
                  AutoRoute(page: DetailsCarRoute.page),
                ]
              ),
              AutoRoute(page: UserOrderRouter.page, path: 'order',
                children: [
                  AutoRoute(path: '', page: OrdersRoute.page),
                  AutoRoute(page: DetailsOrderRoute.page),
                  AutoRoute(page: OrderOffersRoute.page),
                  AutoRoute(page: DetailsOfferRoute.page),
                  AutoRoute(page: StoreRoute.page),
                ]
              ),
              AutoRoute(page: UserProfileRoute.page)
            ],
            guards: [UserGuard(authCubit)]
        ),
        AutoRoute(page: UserFormRouter.page, path: 'user-form',
          children: [
            AutoRoute(path: '', page: CreateCarRoute.page),
            AutoRoute(page: CreateOrderRoute.page),
            AutoRoute(page: ChangeProfileRoute.page),
            AutoRoute(page: SupportRoute.page),

          ],
          guards: [UserGuard(authCubit)]
        ),
        AutoRoute(page: PickerRouter.page,
            children: [
              AutoRoute(page: ProducerPickerRoute.page),
              AutoRoute(page: CarModelPickerRoute.page),
              AutoRoute(page: CityPickerRoute.page),
              AutoRoute(page: RateOrderRoute.page),
              AutoRoute(page: YearPickerRoute.page),
              AutoRoute(page: VolumePickerRoute.page),
            ]
        ),
        AutoRoute(path: 'store', page: StoreRouter.page,
            children: [
              AutoRoute(page: StoreOrderRouter.page, path: '',
                children: [
                  AutoRoute(path: '', page: StoreOrdersRoute.page),
                  AutoRoute(path: '', page: DetailsOrderStoreRoute.page),

                ]
              ),
              AutoRoute(page: StoreOfferRouter.page,
                children: [
                    AutoRoute(path: '', page: MyOffersRoute.page),
                ]
              ),
              AutoRoute(page: StoreProfileRoute.page),
            ],
            guards: [StoreGuard(authStoreCubit)]
        ),
        AutoRoute(page: StoreFormRouter.page, path: 'store-form',
            children: [
              AutoRoute(page: ChangeStoreRoute.page),
              AutoRoute(page: CreateOfferRoute.page),
              AutoRoute(page: ChangeCategoryRoute.page),

            ],
            guards: [StoreGuard(authStoreCubit)]
        ),
        AutoRoute(
          path: 'auth',
          page: AuthRouter.page,
          children: [
            AutoRoute(page: LoginRoute.page, path: ''),
            AutoRoute(page: StoreLoginRoute.page),
            AutoRoute(page: RegisterRoute.page),
          ], guards: [NotAuthGuard(authCubit, authStoreCubit)]
        ),
        // RedirectRoute(path: '*', redirectTo: '/')

      ]
    ),


    AutoRoute(
        page: DocumentRouter.page,
        children: [
          AutoRoute(page: DocumentsRoute.page, path: ''),
          AutoRoute(page: PrivacyRoute.page),
          AutoRoute(page: ContractOfferRoute.page),

        ]
    ),
    RedirectRoute(path: '*', redirectTo: '/auth')


  ];
}

@RoutePage(name: 'AuthRouter')
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Auth Screen');
    return AutoRouter();
  }
}

@RoutePage(name: 'UserOrderRouter')
class UserOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('UserOrderRouter');

    return AutoRouter();
  }
}

@RoutePage(name: 'UserCarRouter')
class UserCarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('UserCarRouter');

    return AutoRouter();
  }
}

@RoutePage(name: 'UserFormRouter')
class UserFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('UserFormRouter');

    return AutoRouter();
  }
}

@RoutePage(name: 'StoreFormRouter')
class StoreFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('StoreFormRouter');

    return AutoRouter();
  }
}

@RoutePage(name: 'StoreOrderRouter')
class StoreOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('StoreOrderRouter');

    return AutoRouter();
  }
}

@RoutePage(name: 'StoreOfferRouter')
class StoreOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('StoreOfferRouter');

    return AutoRouter();
  }
}



@RoutePage(name: 'PickerRouter')
class PickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('PickerRouter');

    return AutoRouter();
  }
}