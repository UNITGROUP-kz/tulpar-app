import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/dictionary/order_model.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/cards/car_card.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/tiles/store_tile.dart';

import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/tiles/data_tile.dart';

@RoutePage()
class DetailsOrderScreen extends StatefulWidget {

  final OrderModel order;

  const DetailsOrderScreen({super.key, required this.order});

  @override
  State<DetailsOrderScreen> createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  _toOffers() {
    context.router.navigate(
      OrderOffersRoute(order: widget.order)
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Details Order');
    return ScreenDefaultTemplate(
      scrollController: _scrollController,
      children: [
        Header(title: 'Заказ'),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarCard(
                car: widget.order.car!
              ),
              Text(widget.order.title, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),

              // DataTile(title: 'Машина', data: widget.order.car?.name),
              DataTile(title: 'Город', data: widget.order.city?.name),
              DataTile(title: 'Запчасть', data: widget.order.part?.name),

              SizedBox(height: 20),
              if(widget.order.comment != null) ...[
                Text('Описание', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                Text(widget.order.comment!, style: TextStyle(fontSize: 17),),
              ],

              if(widget.order.store != null)  ...[
                SizedBox(height: 10),
                Text('Исполнитель заказа: ', style: TextStyle(fontSize: 17),),
                SizedBox(height: 5),
                StoreTile(store: widget.order.store!),
              ],
              if(widget.order.status == OrderStatus.moderation) ...[
                SizedBox(height: 20),
                ElevatedButtonWidget(onPressed: _toOffers, child: Text('Предложения'))
              ]

            ],
          ),
        ),




      ],
    );
  }
}