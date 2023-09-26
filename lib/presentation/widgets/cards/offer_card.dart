
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/widgets/tiles/data_tile.dart';

import '../../../data/models/dictionary/offer_model.dart';
import '../../routing/router.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback? callback;

  const OfferCard({super.key, required this.offer, this.callback});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('№ ${offer.id}', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
              SizedBox(height: 10),
              DataTile(title: 'Производитель', data: offer.producer, isDivider: false),
              DataTile(title: 'Доставка', data: offer.delivery, isDivider: false),
              if(offer.order != null) DataTile(
                  title: 'Статус заказа',
                  data: offer.order!.status.toString(),
                  isDivider: false
              ),

              Divider(thickness: 1),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(offer.condition.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                    ),
                    Container(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                    Expanded(
                      child: Text('${offer.price} тг', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                    )

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}