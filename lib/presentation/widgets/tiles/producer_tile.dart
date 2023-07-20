
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/producer_model.dart';

class ProducerTile extends StatelessWidget {
  final ProducerModel producer;
  final VoidCallback? callback;

  const ProducerTile({super.key, required this.producer, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(producer.name)
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }

}