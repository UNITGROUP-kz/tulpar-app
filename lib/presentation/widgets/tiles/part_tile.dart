
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/group_model.dart';
import '../../../data/models/dictionary/part_model.dart';

class PartTile extends StatelessWidget {
  final PartModel part;
  final VoidCallback? callback;

  const PartTile({super.key, required this.part, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Text(part.name)),
              ElevatedButton(onPressed: callback, child: Text('Заказать'))
            ],
          ),
        ),
        Divider(thickness: 1)
      ],
    );
  }

}