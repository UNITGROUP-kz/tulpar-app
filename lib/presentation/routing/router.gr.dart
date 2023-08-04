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
    CityPickerRoute.name: (routeData) {
      return AutoRoutePage<CityModel>(
        routeData: routeData,
        child: CityPickerScreen(),
      );
    },
    ProducerPickerRoute.name: (routeData) {
      return AutoRoutePage<ProducerModel>(
        routeData: routeData,
        child: ProducerPickerScreen(),
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
    RateOrderRoute.name: (routeData) {
      final args = routeData.argsAs<RateOrderRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RateOrderScreen(
          key: args.key,
          order: args.order,
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
    CreateCarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateCarScreen(),
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
    MyCarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyCarScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterScreen(
          key: args.key,
          emailPhone: args.emailPhone,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(),
      );
    },
    ChangeProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangeProfileScreen(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserProfileScreen(),
      );
    },
    DocumentsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DocumentsScreen(),
      );
    },
    DocumentRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DocumentSplashScreen(),
      );
    },
    PrivacyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PrivacyScreen(),
      );
    },
    ContractOfferRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContractOfferScreen(),
      );
    },
    SplashRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SplashScreen(),
      );
    },
    StoreRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoreSplashScreen(),
      );
    },
    StoreOrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoreOrdersScreen(),
      );
    },
    CreateOfferRoute.name: (routeData) {
      final args = routeData.argsAs<CreateOfferRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateOfferScreen(
          key: args.key,
          order: args.order,
        ),
      );
    },
    MyOffersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyOffersScreen(),
      );
    },
    StoreLoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoreLoginScreen(),
      );
    },
    StoreProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StoreProfileScreen(),
      );
    },
    ChangeStoreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangeStoreScreen(),
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
    StoreFormRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoreFormScreen(),
      );
    },
    StoreOrderRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoreOrderScreen(),
      );
    },
    StoreOfferRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoreOfferScreen(),
      );
    },
    PickerRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PickerScreen(),
      );
    },
    DetailsOrderStoreRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsOrderStoreRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsOrderStoreScreen(
          key: args.key,
          order: args.order,
        ),
      );
    },
  };
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
/// [CityPickerScreen]
class CityPickerRoute extends PageRouteInfo<void> {
  const CityPickerRoute({List<PageRouteInfo>? children})
      : super(
          CityPickerRoute.name,
          initialChildren: children,
        );

  static const String name = 'CityPickerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [RateOrderScreen]
class RateOrderRoute extends PageRouteInfo<RateOrderRouteArgs> {
  RateOrderRoute({
    Key? key,
    required OrderModel order,
    List<PageRouteInfo>? children,
  }) : super(
          RateOrderRoute.name,
          args: RateOrderRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'RateOrderRoute';

  static const PageInfo<RateOrderRouteArgs> page =
      PageInfo<RateOrderRouteArgs>(name);
}

class RateOrderRouteArgs {
  const RateOrderRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final OrderModel order;

  @override
  String toString() {
    return 'RateOrderRouteArgs{key: $key, order: $order}';
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
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    String? emailPhone,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(
            key: key,
            emailPhone: emailPhone,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<RegisterRouteArgs> page =
      PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    this.emailPhone,
  });

  final Key? key;

  final String? emailPhone;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, emailPhone: $emailPhone}';
  }
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
/// [ChangeProfileScreen]
class ChangeProfileRoute extends PageRouteInfo<void> {
  const ChangeProfileRoute({List<PageRouteInfo>? children})
      : super(
          ChangeProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

/// generated route for
/// [DocumentsScreen]
class DocumentsRoute extends PageRouteInfo<void> {
  const DocumentsRoute({List<PageRouteInfo>? children})
      : super(
          DocumentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DocumentsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DocumentSplashScreen]
class DocumentRouter extends PageRouteInfo<void> {
  const DocumentRouter({List<PageRouteInfo>? children})
      : super(
          DocumentRouter.name,
          initialChildren: children,
        );

  static const String name = 'DocumentRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivacyScreen]
class PrivacyRoute extends PageRouteInfo<void> {
  const PrivacyRoute({List<PageRouteInfo>? children})
      : super(
          PrivacyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ContractOfferScreen]
class ContractOfferRoute extends PageRouteInfo<void> {
  const ContractOfferRoute({List<PageRouteInfo>? children})
      : super(
          ContractOfferRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContractOfferRoute';

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
/// [StoreOrdersScreen]
class StoreOrdersRoute extends PageRouteInfo<void> {
  const StoreOrdersRoute({List<PageRouteInfo>? children})
      : super(
          StoreOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoreOrdersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateOfferScreen]
class CreateOfferRoute extends PageRouteInfo<CreateOfferRouteArgs> {
  CreateOfferRoute({
    Key? key,
    required OrderModel order,
    List<PageRouteInfo>? children,
  }) : super(
          CreateOfferRoute.name,
          args: CreateOfferRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateOfferRoute';

  static const PageInfo<CreateOfferRouteArgs> page =
      PageInfo<CreateOfferRouteArgs>(name);
}

class CreateOfferRouteArgs {
  const CreateOfferRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final OrderModel order;

  @override
  String toString() {
    return 'CreateOfferRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [MyOffersScreen]
class MyOffersRoute extends PageRouteInfo<void> {
  const MyOffersRoute({List<PageRouteInfo>? children})
      : super(
          MyOffersRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyOffersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StoreLoginScreen]
class StoreLoginRoute extends PageRouteInfo<void> {
  const StoreLoginRoute({List<PageRouteInfo>? children})
      : super(
          StoreLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoreLoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StoreProfileScreen]
class StoreProfileRoute extends PageRouteInfo<void> {
  const StoreProfileRoute({List<PageRouteInfo>? children})
      : super(
          StoreProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoreProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangeStoreScreen]
class ChangeStoreRoute extends PageRouteInfo<void> {
  const ChangeStoreRoute({List<PageRouteInfo>? children})
      : super(
          ChangeStoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeStoreRoute';

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
/// [StoreFormScreen]
class StoreFormRouter extends PageRouteInfo<void> {
  const StoreFormRouter({List<PageRouteInfo>? children})
      : super(
          StoreFormRouter.name,
          initialChildren: children,
        );

  static const String name = 'StoreFormRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StoreOrderScreen]
class StoreOrderRouter extends PageRouteInfo<void> {
  const StoreOrderRouter({List<PageRouteInfo>? children})
      : super(
          StoreOrderRouter.name,
          initialChildren: children,
        );

  static const String name = 'StoreOrderRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StoreOfferScreen]
class StoreOfferRouter extends PageRouteInfo<void> {
  const StoreOfferRouter({List<PageRouteInfo>? children})
      : super(
          StoreOfferRouter.name,
          initialChildren: children,
        );

  static const String name = 'StoreOfferRouter';

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
/// [DetailsOrderStoreScreen]
class DetailsOrderStoreRoute extends PageRouteInfo<DetailsOrderStoreRouteArgs> {
  DetailsOrderStoreRoute({
    Key? key,
    required OrderModel order,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsOrderStoreRoute.name,
          args: DetailsOrderStoreRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsOrderStoreRoute';

  static const PageInfo<DetailsOrderStoreRouteArgs> page =
      PageInfo<DetailsOrderStoreRouteArgs>(name);
}

class DetailsOrderStoreRouteArgs {
  const DetailsOrderStoreRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final OrderModel order;

  @override
  String toString() {
    return 'DetailsOrderStoreRouteArgs{key: $key, order: $order}';
  }
}
