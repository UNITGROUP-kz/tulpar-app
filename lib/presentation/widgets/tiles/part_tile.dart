
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/cart/cart_cubit.dart';

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${part.number}. ${part.name}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                    Text("${part.notice}", maxLines: 2),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  ElevatedButton(onPressed: callback, child: Text('Заказать')),
                  SizedBox(height: 5),
                  ElevatedButton(onPressed: () {
                    context.read<CartCubit>().add(part.id);
                  }, child: Text('В корзину')),

                ],
              )
            ],
          ),
        ),
        Divider(thickness: 1)
      ],
    );
  }

}