import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StarPickerController extends ValueNotifier<int> {
  StarPickerController({value = 3}): super(value);

  _change(int index) {
    value = index;
    notifyListeners();
  }
}

class StarPicker extends StatelessWidget {

  final StarPickerController controller;

  const StarPicker({super.key, required this.controller});

  _change(int index) => () {
    controller._change(index);
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          builder: (context, int value, Widget? child) {
            return Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: _change(index + 1),
                  child: Icon(
                    Icons.star_rate_rounded,
                    color: (value >= index + 1)? Theme.of(context).colorScheme.primary: Colors.grey.shade500,
                    size: MediaQuery.of(context).size.width / 10,
                  ),
                );
              }
              ),
            );
          },
          valueListenable: controller,
        )
      ],
    );
  }

}