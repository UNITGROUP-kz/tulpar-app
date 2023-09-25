import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/params/dictionary/index_group_params.dart';

import '../../../../data/models/dictionary/car_model.dart';
import '../../../../data/models/dictionary/group_model.dart';
import '../../../../logic/bloc/dictionary/group_picker/group_picker_cubit.dart';

class GroupControllerValue {
  List<GroupModel> checkParent;
  List<GroupModel> choseChild;

  GroupControllerValue({
    required this.choseChild,
    required this.checkParent
  });
}

class GroupController extends ValueNotifier<GroupControllerValue> {
  GroupController({GroupControllerValue? value}) : super(value ?? GroupControllerValue(choseChild: [], checkParent: []));

  checkParent(GroupModel group, bool isMulti) {
    if(value.checkParent.any((element) => group.id == element.id)) {
      value.checkParent = value.checkParent.where((element) => element.id != group.id).toList();
    } else {
      value.checkParent.add(group);
    }
    if(!isMulti) value.choseChild = [];
    notifyListeners();
  }

  choseChild(GroupModel group) {
    if(value.choseChild.any((element) => group.id == element.id)) {
      value.choseChild = value.choseChild.where((element) => element.id != group.id).toList();
    } else {
      value.choseChild.add(group);
    }
    notifyListeners();
  }

  choseOneChild(GroupModel group) {
    value.choseChild = [group];
    notifyListeners();
  }


}

class GroupPicker extends StatefulWidget {
  final CarModel car;
  final bool isMulti;
  GroupController? controller;

  GroupPicker({super.key, this.controller, this.isMulti = false, required this.car});

  @override
  State<GroupPicker> createState() => _GroupPickerState();
}

class _GroupPickerState extends State<GroupPicker> {
  
  VoidCallback _onPressParent(GroupModel group) => () {
      widget.controller?.checkParent(group, widget.isMulti);
  };
  
  VoidCallback _onPressChild(GroupModel group) => () {
    if(widget.isMulti) {
      widget.controller?.choseChild(group);
    } else {
      widget.controller?.choseOneChild(group);
    }
  };



  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller!,
      builder: (context, value, child) {
        print(value);
        return BlocBuilder<GroupPickerCubit, GroupPickerState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: state.groups.map((group) {
                return GroupTile(
                  onPressParent: _onPressParent,
                  onPressChild: _onPressChild,
                  group: group,
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
    context.read<GroupPickerCubit>().fetch(IndexGroupParams(car: widget.car));
    widget.controller ??= GroupController();
    super.initState();
  }


  @override
  void didUpdateWidget(covariant GroupPicker oldWidget) {
    widget.controller ??= oldWidget.controller;
    super.didUpdateWidget(oldWidget);
  }
}

class GroupTile extends StatelessWidget {
  final GroupModel group;
  final VoidCallback Function(GroupModel) onPressParent;
  final VoidCallback Function(GroupModel) onPressChild;
  final GroupControllerValue value;

  const GroupTile({
    super.key,
    required this.group,
    required this.onPressParent,
    required this.onPressChild,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    if (group.childs!.isEmpty) {
      return GroupChildTile(group: group, onPressChild: onPressChild, value: value);
    } else {
      return GroupParentTile(group: group, onPressParent: onPressParent, value: value, onPressChild: onPressChild);
    }
  }

}

class GroupParentTile extends StatelessWidget {
  final GroupModel group;
  final VoidCallback Function(GroupModel) onPressParent;
  final VoidCallback Function(GroupModel) onPressChild;

  final GroupControllerValue value;

  const GroupParentTile({
    super.key,
    required this.group,
    required this.onPressParent,
    required this.value,
    required this.onPressChild
  });

  @override
  Widget build(BuildContext context) {
    final visibleChild = value.checkParent.any((element) => element.id == group.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressParent(group),
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
                          color: Theme.of(context).colorScheme.primary
                      )
                  ),
                  child: Icon(visibleChild? Icons.remove : Icons.add, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(group.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if(visibleChild && group.childs!.isNotEmpty) ...group.childs!.map((e) {
          return Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: GroupTile(group: e, onPressParent: onPressParent, value: value, onPressChild: onPressChild),
          );
        }).toList(),
        const Divider(height: 0),
      ],
    );
  }
}

class GroupChildTile extends StatelessWidget {
  final GroupModel group;
  final VoidCallback Function(GroupModel) onPressChild;
  final GroupControllerValue value;

  const GroupChildTile({super.key, required this.group, required this.onPressChild, required this.value});

  @override
  Widget build(BuildContext context) {
    final visibleChild = value.choseChild.any((element) => element.id == group.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onPressChild(group),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Text(group.name, style: TextStyle(
                fontWeight: visibleChild ? FontWeight.w800 : FontWeight.w600,
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