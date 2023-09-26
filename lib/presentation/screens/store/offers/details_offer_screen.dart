
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:garage/presentation/widgets/cards/order_card.dart';
import '../../../../data/models/dictionary/offer_model.dart';
import '../../../../data/models/dictionary/order_model.dart';
import '../../../routing/router.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/screen_templates/screen_default_template.dart';
import '../../../widgets/tiles/data_tile.dart';

@RoutePage()
class DetailsOfferStoreScreen extends StatefulWidget {

  final OfferModel offer;

  const DetailsOfferStoreScreen({super.key, required this.offer});

  @override
  State<DetailsOfferStoreScreen> createState() => _DetailsOfferStoreScreenState();
}

class _DetailsOfferStoreScreenState extends State<DetailsOfferStoreScreen> {

  _onTap(OrderModel order) => () {
    context.router.navigate(SplashRouter(
        children: [
          StoreRouter(
              children: [
                StoreOrderRouter(
                    children: [
                      DetailsOrderStoreRoute(order: order)
                    ]
                )
              ]
          )
        ]
    ));
  };


  @override
  Widget build(BuildContext context) {
    print('Details Offer');
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Заказ'),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              if(widget.offer.order != null) OrderCard(
                  order: widget.offer.order!,
                  callback: _onTap(widget.offer.order!),
              ),
              SizedBox(height: 10),
              DataTile(title: 'Поставщик', data: widget.offer.producer),
              DataTile(title: 'Доставка', data: widget.offer.delivery),
              DataTile(title: 'Состояние', data: widget.offer.condition.toString()),

            ],
          ),
        )
      ],
    );
  }
}