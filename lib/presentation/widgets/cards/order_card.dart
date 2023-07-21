
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/order_model.dart';
import '../../routing/router.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  _toDetails(BuildContext context) => () {
    context.router.navigate(DetailsOrderRoute(order: order));
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            Text(order.title),
            Text(order.status.name),
            Text(order.part?.name ?? 'Неизвестно'),
            Text(order.store?.name ?? 'Нет магазина')
          ],
        ),
      ),
    );
  }

}