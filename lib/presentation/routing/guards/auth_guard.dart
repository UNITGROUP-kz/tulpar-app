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
    print(auth.isLogin);
    print(authStore.isLogin);

    if(auth.isLogin) {
      _toUser(resolver);
    } else if(authStore.isLogin) {
      _toStore(resolver);
    } else {
      resolver.next();
    }

    authStore.stream.listen(_listenStore(resolver));
    auth.stream.listen(_listenUser(resolver));

  }

  _listenStore(NavigationResolver resolver) => (AuthStoreState state) {
    if(state.isLogin) {
      print(state.isLogin);
      _toStore(resolver);
    }
  };

  _listenUser(NavigationResolver resolver) => (AuthState state) {
    if(state.isLogin) {
      print(state.isLogin);
      _toUser(resolver);
    }
  };

  _toUser(NavigationResolver resolver) {
    resolver.redirect(SplashRouter(
        children: [
          UserRouter(
              children: [
                UserCarRouter()
              ]
          )
        ]
    ));
  }

  _toStore(NavigationResolver resolver) {
    resolver.redirect(SplashRouter(
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