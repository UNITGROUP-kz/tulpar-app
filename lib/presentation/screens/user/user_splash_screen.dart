
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/routing/router.dart';


@RoutePage(name: 'UserRouter')
class UserSplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('User');

    return AutoTabsRouter(
      routes: const [
        UserCarRouter(),
        UserOrderRouter(),
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
                  BottomItem(icon: Icons.garage, index:  1,)
                ],
              ),
            )
          ],
        );
      },
    );
  }
}


class BottomItem extends StatelessWidget {
  final IconData icon;
  final int index;

  const BottomItem({super.key, required this.icon, required this.index});

  _toPage(BuildContext context) => () {
    AutoTabsRouter.of(context).setActiveIndex(index);
  };

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: _toPage(context),
      child: Icon(icon, color: AutoTabsRouter.of(context).activeIndex == index?  Theme.of(context).colorScheme.primary : null,),
    );
  }


}