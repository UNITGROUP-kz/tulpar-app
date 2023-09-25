
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/group_model.dart';

class GroupTile extends StatelessWidget {
  final GroupModel group;
  final VoidCallback? callback;

  const GroupTile({super.key, required this.group, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Text(group.name)),
              ElevatedButton(onPressed: callback, child: Text('Заказать'))
            ],
          ),
        ),
        Divider(thickness: 1)
      ],
    );
  }

}