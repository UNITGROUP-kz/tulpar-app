import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'SplashRouter')
class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('Splash');

    return Scaffold(
      body: SafeArea(
        child: AutoRouter(
          // placeholder: (context) {
          //   return Container(
          //     color: Colors.white,
          //     height: MediaQuery.of(context).size.height,
          //     width: double.infinity,
          //     child: Center(child: CupertinoActivityIndicator()),
          //   );
          // },
        ),
      ),
    );
  }
}
