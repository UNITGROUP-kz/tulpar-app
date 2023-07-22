
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String label;
  final Widget? child;
  final VoidCallback? callback;
  final EdgeInsets padding;

  const SettingsTile({super.key, required this.label, this.child, this.callback, this.padding = const EdgeInsets.all(15)});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: padding,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            if(child != null) child!
          ],
        ),
      ),
    );
  }


}