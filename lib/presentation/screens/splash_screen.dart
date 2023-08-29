import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/store/auth/auth_store_cubit.dart';
import 'package:garage/logic/bloc/store/auth/auth_store_cubit.dart';

import '../../logic/bloc/store/login/login_store_cubit.dart';

@RoutePage(name: 'SplashRouter')
class SplashScreen extends StatelessWidget {

  _listenerLogin(BuildContext context, LoginStoreState state) {

  }

  @override
  Widget build(BuildContext context) {
    print('Splash Screen');
    print(context.router.current.path);
    print(context.router.current.name);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginStoreCubit, LoginStoreState>(
          listener: _listenerLogin,
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
      ),
    );
  }
}
