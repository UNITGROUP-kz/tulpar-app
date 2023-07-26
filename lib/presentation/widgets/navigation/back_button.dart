import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {

  _back(BuildContext context) => () {
    context.router.pop();
  };

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: _back(context), icon: Icon(Icons.arrow_back_ios));
  }

}