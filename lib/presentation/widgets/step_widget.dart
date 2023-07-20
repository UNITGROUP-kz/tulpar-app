import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {
  final int maxStep;
  final int currentStep;

  late Color? focusedColor;
  final Color? disableColor;

  StepWidget({
    super.key,
    required this.maxStep,
    required this.currentStep,
    this.focusedColor = Colors.blue,
    this.disableColor = Colors.grey
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(maxStep, (index) {
        print(index);
        return Expanded(
          child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                        color: index + 1 <= currentStep? focusedColor: disableColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                if(maxStep > index + 1) SizedBox(width: 5),
              ]
          ),
        );
      })
    );

  }

}