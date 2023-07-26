import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isRequired;

  PhoneFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired = false,
  });

  final _maskFormatter = MaskTextInputFormatter(
      mask: '+###########',

      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );


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
            inputFormatters: [_maskFormatter],
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