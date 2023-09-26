import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const OutlinedButtonWidget({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }

}