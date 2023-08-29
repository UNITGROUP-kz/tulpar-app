import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/dictionary/part_picker/part_picker_cubit.dart';

import '../../../../data/models/dictionary/part_model.dart';

class PartControllerValue {
  List<PartModel> checkParent = [];
  List<PartModel> choseChild = [];
}

class PartController extends ValueNotifier<PartControllerValue> {
  PartController({PartControllerValue? value}) : super(value ?? PartControllerValue());

  checkParent(PartModel part, bool isMulti) {
    if(value.checkParent.any((element) => part.id == element.id)) {
      value.checkParent = value.checkParent.where((element) => element.id != part.id).toList();
    } else {
      value.checkParent.add(part);
    }
    if(!isMulti) value.choseChild = [];
    notifyListeners();
  }

  choseChild(PartModel part) {
    if(value.choseChild.any((element) => part.id == element.id)) {
      value.choseChild = value.choseChild.where((element) => element.id != part.id).toList();
    } else {
      value.choseChild.add(part);
    }
    notifyListeners();
  }

  choseOneChild(PartModel part) {
    value.choseChild = [part];
    notifyListeners();
  }


}

class PartPicker extends StatefulWidget {
  final bool isMulti;
  PartController? controller;

  PartPicker({super.key, this.controller, this.isMulti = false});

  @override
  State<PartPicker> createState() => _PartPickerState();
}

class _PartPickerState extends State<PartPicker> {
  
  VoidCallback _onPressParent(PartModel part) => () {
      widget.controller?.checkParent(part, widget.isMulti);
  };
  
  VoidCallback _onPressChild(PartModel part) => () {
    if(widget.isMulti) {
      widget.controller?.choseChild(part);
    } else {
      widget.controller?.choseOneChild(part);
    }
  };



  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller!,
      builder: (context, value, child) {
        print(value);
        return BlocBuilder<PartPickerCubit, PartPickerState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: state.parts.map((part) {
                return PartTile(
                  onPressParent: _onPressParent,
                  onPressChild: _onPressChild,
                  part: part,
                  value: value,
                );
              }).toList()
            );
          },
        );
      }
    );
  }

  @override
  void initState() {
    widget.controller ??= PartController();
    super.initState();
  }


  @override
  void didUpdateWidget(covariant PartPicker oldWidget) {
    widget.controller ??= oldWidget.controller;
    super.didUpdateWidget(oldWidget);
  }
}

class PartTile extends StatelessWidget {
  final PartModel part;
  final VoidCallback Function(PartModel) onPressParent;
  final VoidCallback Function(PartModel) onPressChild;
  final PartControllerValue value;

  const PartTile({
    super.key,
    required this.part,
    required this.onPressParent,
    required this.onPressChild,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    if (part.childs!.isEmpty) {
      return PartChildTile(part: part, onPressChild: onPressChild);
    } else {
      return PartParentTile(part: part, onPressParent: onPressParent, value: value, onPressChild: onPressChild);
    }
  }

}

class PartParentTile extends StatelessWidget {
  final PartModel part;
  final VoidCallback Function(PartModel) onPressParent;
  final VoidCallback Function(PartModel) onPressChild;

  final PartControllerValue value;

  const PartParentTile({
    super.key,
    required this.part,
    required this.onPressParent,
    required this.value,
    required this.onPressChild
  });

  @override
  Widget build(BuildContext context) {
    final visibleChild = value.checkParent.any((element) => element.id == part.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressParent(part),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 0.5,
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  child: Icon(visibleChild? Icons.remove : Icons.add, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(width: 10),
                Text(part.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                  ),
                )
              ],
            ),
          ),
        ),
        if(visibleChild && part.childs!.isNotEmpty) ...part.childs!.map((e) {
          return Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: PartTile(part: e, onPressParent: onPressParent, value: value, onPressChild: onPressChild),
          );
        }).toList(),
        const Divider(height: 0),
      ],
    );
  }
}

class PartChildTile extends StatelessWidget {
  final PartModel part;
  final VoidCallback Function(PartModel) onPressChild;


  const PartChildTile({super.key, required this.part, required this.onPressChild});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onPressChild(part),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Text(part.name, style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15
              )
            ),
          ),
        ),
        Divider(height: 0,)
      ],
    );
  }

}