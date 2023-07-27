import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final bool isRequired;
  final Widget? icon;
  final Function(String)? onSubmit;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.label,
    this.isRequired = false,
    this.icon,
    this.onSubmit
  });


  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null) Text.rich(TextSpan(
            children: [
              TextSpan(text: label),
              if(isRequired) TextSpan(text: '*', style: TextStyle(color: Colors.red))
            ]
        )),
        SizedBox(height: 5),
        Container(
          height: 55,
          child: TextField(
            onSubmitted: onSubmit,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: icon,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ),
      ],
    );
  }

}