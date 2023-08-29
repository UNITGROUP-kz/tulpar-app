
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String label;
  final Widget? child;
  final VoidCallback? callback;
  final EdgeInsets padding;
  final IconData icon;
  final Color? backgroundIcon;

  const SettingsTile({
    super.key,
    required this.label,
    this.child,
    this.callback,
    this.padding = const EdgeInsets.all(10),
    required this.icon,
    this.backgroundIcon
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: padding,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: backgroundIcon ?? Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5)
              ),
              width: 30,
              height: 30,
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            SizedBox(width: 10),
            Expanded(child: Text(label)),
            if(child != null) child!
          ],
        ),
      ),
    );
  }


}