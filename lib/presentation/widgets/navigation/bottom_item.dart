
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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