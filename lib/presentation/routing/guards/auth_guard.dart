import 'package:auto_route/auto_route.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../logic/bloc/store/auth/auth_store_cubit.dart';

class UserGuard extends AutoRouteGuard {
  final AuthCubit auth;

  UserGuard(this.auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _check(resolver, router)(auth.state);
    auth.stream.listen(_check(resolver, router));
  }

  _check(NavigationResolver resolver, StackRouter router) => (AuthState state) {
    if(state.auth != null && !resolver.isResolved) {
      resolver.next();
    } else {
      router.replace(LoginRoute());
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
    print(auth.isLogin);
    print(authStore.isLogin);

    if(auth.isLogin) {
      _toUser(router);
    } else if(authStore.isLogin) {
      _toStore(router);
    } else {
      resolver.next();
    }

    authStore.stream.listen(_listenStore(router));
    auth.stream.listen(_listenUser(router));

  }

  _listenStore(StackRouter router) => (AuthStoreState state) {
    if(state.isLogin) {
      _toStore(router);
    }
  };

  _listenUser(StackRouter router) => (AuthState state) {
    if(state.isLogin) {
      _toUser(router);
    }
  };

  _toUser(StackRouter router) {
    router.replace(SplashRouter(
        children: [
          UserRouter(
              children: [
                UserCarRouter()
              ]
          )
        ]
    ));
  }

  _toStore(StackRouter router) {
    router.replace(SplashRouter(
        children: [
          StoreRouter(
              children: [
                StoreOrderRouter()
              ]
          )
        ]
    ));
  }

}