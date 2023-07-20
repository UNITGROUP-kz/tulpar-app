import 'package:auto_route/auto_route.dart';
import 'package:garage/logic/bloc/user/auth/auth_cubit.dart';
import 'package:garage/presentation/routing/router.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit auth;

  AuthGuard(this.auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {

    if(auth.isLogin) return resolver.next();

    router.navigate(LoginRoute());


  }
}

class UserGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next();
  }
}