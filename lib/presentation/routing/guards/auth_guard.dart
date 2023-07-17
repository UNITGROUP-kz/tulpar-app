import 'package:auto_route/auto_route.dart';
import 'package:garage/presentation/routing/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if(true) {
      router.navigate(LoginRoute());
    }

    resolver.next();
  }
}

class UserGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next();
  }
}