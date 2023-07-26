import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isRequired;

  const DescriptionFieldWidget({
    super.key,
    required this.controller,
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
        TextField(
          
          controller: controller,
          
          maxLines: 5,
          
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            
          ),
        )
      ]
    );
  }

}