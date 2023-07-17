import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSuccessSnackBar(BuildContext context, String success) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 40,
      backgroundColor: Theme.of(context).colorScheme.background,
      duration: Duration(seconds: 5),
      content: Row(
        children: [
          Icon(
              Icons.check_circle_rounded,

          ),
          SizedBox(width: 15,),
          Expanded(
            child: Text(success),
          ),
        ],
      )
  )
  );
}