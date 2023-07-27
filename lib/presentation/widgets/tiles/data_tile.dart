import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataTile extends StatelessWidget {
  final String title;
  final String? data;
  final bool isDivider;

  const DataTile({super.key, required this.title, this.data, this.isDivider = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)
              ),
              if(data != null) Expanded(
                  flex: 2,
                  child: Text(
                      data!,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
                  )
              ),

            ],
          ),
          if(isDivider) Divider(thickness: 1)
          else SizedBox(height: 2)
        ],
      ),
    );
  }

}