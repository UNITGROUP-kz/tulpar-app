
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'StoreRouter')
class StoreSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [

      ],
      transitionBuilder: (context,child,animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return SafeArea(
          child: Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  // here we switch between tabs
                  tabsRouter.setActiveIndex(index);
                },
                items: [
                  BottomNavigationBarItem(label: 'Users', icon: Icon(Icons.add)),
                  BottomNavigationBarItem(label: 'Users', icon: Icon(Icons.add)),
                  BottomNavigationBarItem(label: 'Users', icon: Icon(Icons.add)),
                ],
              )
          ),
        );
      },
    );
  }

}