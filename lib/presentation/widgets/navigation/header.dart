import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'back_button.dart';

class Header extends StatelessWidget {
  final bool isBack;
  final String? title;
  final Widget? tril;

  const Header({super.key, this.isBack = true, this.title, this.tril});



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          if(isBack) BackButtonWidget(),
          Expanded(
            child: Text(title ?? '', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              )
            )
          ),
          if(tril != null) tril!
        ],
      ),
    );
  }
}