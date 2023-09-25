
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/order_model.dart';
import '../../routing/router.dart';
import '../tiles/data_tile.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? callback;

  const OrderCard({super.key, required this.order, this.callback});



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: callback,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10)
          ),
          width: double.infinity,
          child: Column(
            children: [
              DataTile(title: 'Заголовок', data: order.title, isDivider: false),
              DataTile(title: 'Запчасть', data: order.group?.name ?? 'Неизвестно', isDivider: false),
              if(order.store != null) DataTile(title: 'Магазин', data: order.store?.name ?? 'Нет магазина', isDivider: false),
              if(order.comment != null || order.comment?.isNotEmpty == true)...[
                Divider(thickness: 1),
                Text('Комментарий', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),),
                Text(order.comment ?? 'Нет комментария', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ],
              SizedBox(height: 10),
              Divider(thickness: 1),
              Text(order.status.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    );
  }

}