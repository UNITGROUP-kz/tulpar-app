// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(),
      );
    },
    StoreRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoreSplashScreen(),
      );
    },
    UserRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserSplashScreen(),
      );
    },
    OrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrdersScreen(),
      );
    },
    CreateOrderRoute.name: (routeData) {
      final args = routeData.argsAs<CreateOrderRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateOrderScreen(
          key: args.key,
          part: args.part,
          car: args.car,
        ),
      );
    },
    DetailsOrderRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsOrderRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsOrderScreen(
          key: args.key,
          order: args.order,
        ),
      );
    },
    CreateCarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateCarScreen(),
      );
    },
    MyCarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyCarScreen(),
      );
    },
    SplashRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SplashScreen(),
      );
    },
    UserOrderRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserOrderScreen(),
      );
    },
    UserCarRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserCarScreen(),
      );
    },
    UserFormRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserFormScreen(),
      );
    },
    PickerRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PickerScreen(),
      );
    },
    CarModelPickerRoute.name: (routeData) {
      final args = routeData.argsAs<CarModelPickerRouteArgs>();
      return AutoRoutePage<CarModelModel>(
        routeData: routeData,
        child: CarModelPickerScreen(
          key: args.key,
          producer: args.producer,
        ),
      );
    },
    ProducerPickerRoute.name: (routeData) {
      return AutoRoutePage<ProducerModel>(
        routeData: routeData,
        child: ProducerPickerScreen(),
      );
    },
    DetailsCarRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsCarRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsCarScreen(
          key: args.key,
          car: args.car,
        ),
      );
    },
    OrderOffersRoute.name: (routeData) {
      final args = routeData.argsAs<OrderOffersRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderOffersScreen(
          key: args.key,
          order: args.order,
        ),
      );
    },
    DetailsOfferRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsOfferRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsOfferScreen(
          key: args.key,
          offer: args.offer,
        ),
      );
    },
    UserProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserProfileScreen(),
      );
    },
  };
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StoreSplashScreen]
class StoreRouter extends PageRouteInfo<void> {
  const StoreRouter({List<PageRouteInfo>? children})
      : super(
          StoreRouter.name,
          initialChildren: children,
        );

  static const String name = 'StoreRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserSplashScreen]
class UserRouter extends PageRouteInfo<void> {
  const UserRouter({List<PageRouteInfo>? children})
      : super(
          UserRouter.name,
          initialChildren: children,
        );

  static const String name = 'UserRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrdersScreen]
class OrdersRoute extends PageRouteInfo<void> {
  const OrdersRoute({List<PageRouteInfo>? children})
      : super(
          OrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateOrderScreen]
class CreateOrderRoute extends PageRouteInfo<CreateOrderRouteArgs> {
  CreateOrderRoute({
    Key? key,
    required PartModel part,
    required CarModel car,
    List<PageRouteInfo>? children,
  }) : super(
          CreateOrderRoute.name,
          args: CreateOrderRouteArgs(
            key: key,
            part: part,
            car: car,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateOrderRoute';

  static const PageInfo<CreateOrderRouteArgs> page =
      PageInfo<CreateOrderRouteArgs>(name);
}

class CreateOrderRouteArgs {
  const CreateOrderRouteArgs({
    this.key,
    required this.part,
    required this.car,
  });

  final Key? key;

  final PartModel part;

  final CarModel car;

  @override
  String toString() {
    return 'CreateOrderRouteArgs{key: $key, part: $part, car: $car}';
  }
}

/// generated route for
/// [DetailsOrderScreen]
class DetailsOrderRoute extends PageRouteInfo<DetailsOrderRouteArgs> {
  DetailsOrderRoute({
    Key? key,
    required OrderModel order,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsOrderRoute.name,
          args: DetailsOrderRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsOrderRoute';

  static const PageInfo<DetailsOrderRouteArgs> page =
      PageInfo<DetailsOrderRouteArgs>(name);
}

class DetailsOrderRouteArgs {
  const DetailsOrderRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final OrderModel order;

  @override
  String toString() {
    return 'DetailsOrderRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [CreateCarScreen]
class CreateCarRoute extends PageRouteInfo<void> {
  const CreateCarRoute({List<PageRouteInfo>? children})
      : super(
          CreateCarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateCarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyCarScreen]
class MyCarRoute extends PageRouteInfo<void> {
  const MyCarRoute({List<PageRouteInfo>? children})
      : super(
          MyCarRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyCarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRouter extends PageRouteInfo<void> {
  const SplashRouter({List<PageRouteInfo>? children})
      : super(
          SplashRouter.name,
          initialChildren: children,
        );

  static const String name = 'SplashRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserOrderScreen]
class UserOrderRouter extends PageRouteInfo<void> {
  const UserOrderRouter({List<PageRouteInfo>? children})
      : super(
          UserOrderRouter.name,
          initialChildren: children,
        );

  static const String name = 'UserOrderRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserCarScreen]
class UserCarRouter extends PageRouteInfo<void> {
  const UserCarRouter({List<PageRouteInfo>? children})
      : super(
          UserCarRouter.name,
          initialChildren: children,
        );

  static const String name = 'UserCarRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserFormScreen]
class UserFormRouter extends PageRouteInfo<void> {
  const UserFormRouter({List<PageRouteInfo>? children})
      : super(
          UserFormRouter.name,
          initialChildren: children,
        );

  static const String name = 'UserFormRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PickerScreen]
class PickerRouter extends PageRouteInfo<void> {
  const PickerRouter({List<PageRouteInfo>? children})
      : super(
          PickerRouter.name,
          initialChildren: children,
        );

  static const String name = 'PickerRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CarModelPickerScreen]
class CarModelPickerRoute extends PageRouteInfo<CarModelPickerRouteArgs> {
  CarModelPickerRoute({
    Key? key,
    required ProducerModel producer,
    List<PageRouteInfo>? children,
  }) : super(
          CarModelPickerRoute.name,
          args: CarModelPickerRouteArgs(
            key: key,
            producer: producer,
          ),
          initialChildren: children,
        );

  static const String name = 'CarModelPickerRoute';

  static const PageInfo<CarModelPickerRouteArgs> page =
      PageInfo<CarModelPickerRouteArgs>(name);
}

class CarModelPickerRouteArgs {
  const CarModelPickerRouteArgs({
    this.key,
    required this.producer,
  });

  final Key? key;

  final ProducerModel producer;

  @override
  String toString() {
    return 'CarModelPickerRouteArgs{key: $key, producer: $producer}';
  }
}

/// generated route for
/// [ProducerPickerScreen]
class ProducerPickerRoute extends PageRouteInfo<void> {
  const ProducerPickerRoute({List<PageRouteInfo>? children})
      : super(
          ProducerPickerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProducerPickerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DetailsCarScreen]
class DetailsCarRoute extends PageRouteInfo<DetailsCarRouteArgs> {
  DetailsCarRoute({
    Key? key,
    required CarModel car,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsCarRoute.name,
          args: DetailsCarRouteArgs(
            key: key,
            car: car,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsCarRoute';

  static const PageInfo<DetailsCarRouteArgs> page =
      PageInfo<DetailsCarRouteArgs>(name);
}

class DetailsCarRouteArgs {
  const DetailsCarRouteArgs({
    this.key,
    required this.car,
  });

  final Key? key;

  final CarModel car;

  @override
  String toString() {
    return 'DetailsCarRouteArgs{key: $key, car: $car}';
  }
}

/// generated route for
/// [OrderOffersScreen]
class OrderOffersRoute extends PageRouteInfo<OrderOffersRouteArgs> {
  OrderOffersRoute({
    Key? key,
    required OrderModel order,
    List<PageRouteInfo>? children,
  }) : super(
          OrderOffersRoute.name,
          args: OrderOffersRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderOffersRoute';

  static const PageInfo<OrderOffersRouteArgs> page =
      PageInfo<OrderOffersRouteArgs>(name);
}

class OrderOffersRouteArgs {
  const OrderOffersRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final OrderModel order;

  @override
  String toString() {
    return 'OrderOffersRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [DetailsOfferScreen]
class DetailsOfferRoute extends PageRouteInfo<DetailsOfferRouteArgs> {
  DetailsOfferRoute({
    Key? key,
    required OfferModel offer,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsOfferRoute.name,
          args: DetailsOfferRouteArgs(
            key: key,
            offer: offer,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsOfferRoute';

  static const PageInfo<DetailsOfferRouteArgs> page =
      PageInfo<DetailsOfferRouteArgs>(name);
}

class DetailsOfferRouteArgs {
  const DetailsOfferRouteArgs({
    this.key,
    required this.offer,
  });

  final Key? key;

  final OfferModel offer;

  @override
  String toString() {
    return 'DetailsOfferRouteArgs{key: $key, offer: $offer}';
  }
}

/// generated route for
/// [UserProfileScreen]
class UserProfileRoute extends PageRouteInfo<void> {
  const UserProfileRoute({List<PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
