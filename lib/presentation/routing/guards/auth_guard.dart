import 'package:auto_route/auto_route.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../logic/bloc/store/auth/auth_store_cubit.dart';

class UserGuard extends AutoRouteGuard {
  final AuthCubit auth;

  UserGuard(this.auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _check(resolver)(auth.state);
    auth.stream.listen(_check(resolver));
  }

  _check(NavigationResolver resolver) => (AuthState state) {
    if(state.auth != null && !resolver.isResolved) {
      resolver.next();
    } else {
      resolver.redirect(LoginRoute());
    }
  };
}

class StoreGuard extends AutoRouteGuard {
  final AuthStoreCubit auth;

  StoreGuard(this.auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _check(resolver)(auth.state);
    auth.stream.listen(_check(resolver));
  }

  _check(NavigationResolver resolver) => (AuthStoreState state) {
    if(state.auth != null && !resolver.isResolved) {
      resolver.next();
    } else {
      resolver.redirect(StoreLoginRoute());
    }
  };
}


class NotAuthGuard extends AutoRouteGuard {
  final AuthStoreCubit authStore;
  final AuthCubit auth;

  NotAuthGuard(this.auth, this.authStore);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // _listenAuthStore(resolver)(authStore.state);
    authStore.stream.listen(_listenAuthStore(resolver));

    // _listenAuth(resolver)(auth.state);
    auth.stream.listen(_listenAuth(resolver));

  }

  _listenAuth(NavigationResolver resolver) => (AuthState state) {
    print('auth User: ${state.auth}');

    if(state.auth == null && resolver.isResolved) {
      resolver.next();
    } else {

      resolver.redirect(SplashRouter(
        children: [
          UserRouter(
            children: [
              UserOrderRouter()
            ]
          )
        ]
      ));
    }
  };

  _listenAuthStore(NavigationResolver resolver) => (AuthStoreState state) {
    print('auth Store: ${state.auth}');

    if(state.auth == null && resolver.isResolved) {
      resolver.next();
    } else {
      resolver.redirect(SplashRouter(
          children: [
            StoreRouter(
              children: [
                StoreOrderRouter(
                  children: [
                    StoreOrdersRoute()
                  ]
                )
              ]
            )
          ]
      ));
    }
  };

}