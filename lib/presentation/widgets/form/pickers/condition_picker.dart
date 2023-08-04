import 'package:flutter/cupertino.dart';
import 'package:garage/data/models/dictionary/offer_model.dart';


class ConditionPickerController extends ValueNotifier<ConditionOffer> {
  ConditionPickerController({ ConditionOffer value = ConditionOffer.used}): super(value);

  _change(ConditionOffer condition) {
    value = condition;
    notifyListeners();
  }
}



class ConditionPicker extends StatelessWidget {

  final ConditionPickerController? controller;

  const ConditionPicker({super.key, this.controller});


  void _change(int? value) {
    if(value == null) return;
    controller?._change(ConditionOffer.values[value]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ValueListenableBuilder(
          valueListenable: controller ?? ConditionPickerController(),
          builder: (context, value, child) {
            return CupertinoSlidingSegmentedControl(
                children: ConditionOffer.values.map((e) {
                  return Text(e.toString());
                }).toList().asMap(),
                groupValue: controller?.value.index,
                onValueChanged: _change
            );
          }
      ),
    );
  }

}