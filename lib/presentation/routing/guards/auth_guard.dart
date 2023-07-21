import 'package:auto_route/auto_route.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit auth;

  AuthGuard(this.auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {

    auth.stream.listen((AuthState state) {
      if(state.auth != null) {
        resolver.redirect(LoginRoute());
      } else {
        return resolver.next();
      }
    });

    if(auth.isLogin) return resolver.next();
    resolver.redirect(LoginRoute());
  }
}

class UserGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next();
  }
}