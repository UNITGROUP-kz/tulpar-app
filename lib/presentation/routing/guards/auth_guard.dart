import 'package:auto_route/auto_route.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../logic/bloc/store/auth/auth_store_cubit.dart';

const login = AuthRouter(
    children: [
      LoginRoute()
    ]
);

const storeLogin = AuthRouter(
  children: [
    StoreLoginRoute()
  ]
);

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
      print('next user');

      resolver.next();
    } else {
      print('replace user');

      router.replace(login);
    }
  };
}

class StoreGuard extends AutoRouteGuard {
  final AuthStoreCubit auth;

  StoreGuard(this.auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    print(auth.isLogin);
    _check(resolver)(auth.state);
    auth.stream.listen(_check(resolver));
  }

  _check(NavigationResolver resolver) => (AuthStoreState state) {
    if(state.auth != null && !resolver.isResolved) {
      print('next store');
      resolver.next();
    } else {
      print('redirect store');

      resolver.redirect(storeLogin);
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
    print('redirect user 2');

    router.replace(const SplashRouter(
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
    print('redirect store 2');

    router.replace(const SplashRouter(
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