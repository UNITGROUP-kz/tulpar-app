import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.label,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            children: [
              TextSpan(text: label),
            ]
        )),
        SizedBox(height: 5),

        Container(
          height: 55,
          child: TextField(

            controller: controller,
            obscureText: true,
            obscuringCharacter: '*',
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