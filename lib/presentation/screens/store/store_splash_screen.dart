
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../widgets/navigation/bottom_item.dart';


@RoutePage(name: 'StoreRouter')
class StoreSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        StoreOrderRouter(),
        StoreOfferRouter(),
        StoreProfileRoute()
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomItem(icon: Icons.garage, index: 0),
                  BottomItem(icon: Icons.garage, index: 1,),
                  BottomItem(icon: Icons.garage, index: 2,),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}