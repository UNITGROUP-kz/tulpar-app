
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/order_model.dart';
import '../../routing/router.dart';
import '../tiles/data_tile.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  _toDetails(BuildContext context) => () {
    context.router.navigate(DetailsOrderRoute(order: order));
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: _toDetails(context),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)
          ),
          width: double.infinity,
          child: Column(
            children: [
              DataTile(title: 'Заголовок', data: order.title, isDivider: false),
              DataTile(title: 'Запчасть', data: order.part?.name ?? 'Неизвестно', isDivider: false),
              if(order.store != null) DataTile(title: 'Магазин', data: order.store?.name ?? 'Нет магазина', isDivider: false),
              DataTile(title: 'Комментарий', data: order.comment ?? 'Неизвестно', isDivider: false),

              SizedBox(height: 10),
              Divider(thickness: 1),
              Text(order.status.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            ],
          ),
        ),
      ),
    );
  }

}