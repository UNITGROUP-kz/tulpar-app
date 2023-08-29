import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/store/auth/auth_store_cubit.dart';
import 'package:garage/logic/bloc/store/auth/auth_store_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/buttons/elevated_button.dart';

import '../../data/enums/fetch_status.dart';
import '../../logic/bloc/store/login/login_store_cubit.dart';

@RoutePage(name: 'SplashRouter')
class SplashScreen extends StatelessWidget {

  _listenerLogin(BuildContext context, LoginStoreState state) {
    if(state.status == FetchStatus.success && state.auth?.store.value?.categories == null) {
      showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          useSafeArea: true,
          builder: (context) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Настройте предоставляемые вами услуги, для улучшения качества поиска заказов', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                SizedBox(height: 10),
                ElevatedButtonWidget(onPressed: _toChangeCategories(context), child: Text('Перейти'))
              ],
            ),
          )
      );
    }

  }

  _toChangeCategories(BuildContext context) => () {
    context.router.pop();
    context.router.push(const SplashRouter(
      children: [
        StoreFormRouter(
          children: [
            ChangeCategoryRoute()
          ]
        )
      ]
    ));
  };

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
