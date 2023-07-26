import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocumentTile extends StatelessWidget {
  final VoidCallback? callback;
  final String? title;

  const DocumentTile({super.key, this.callback, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(title ?? '')
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }

}