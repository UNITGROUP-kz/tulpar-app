import 'package:auto_route/auto_route.dart';
import 'package:garage/presentation/screens/auth/login_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true)
  ];
}