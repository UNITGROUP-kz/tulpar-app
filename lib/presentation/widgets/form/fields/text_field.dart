import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool isRequired;

  const TextFieldWidget({
    super.key,
    this.controller,
    required this.label,
    this.isRequired = false
  });


  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            children: [
              TextSpan(text: label),
              if(isRequired) TextSpan(text: '*', style: TextStyle(color: Colors.red))
            ]
        )),
        SizedBox(height: 5),
        Container(
          height: 55,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
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