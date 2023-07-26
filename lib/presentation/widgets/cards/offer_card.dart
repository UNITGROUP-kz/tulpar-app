
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/dictionary/offer_model.dart';
import '../../routing/router.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;

  const OfferCard({super.key, required this.offer});

  _toDetails(BuildContext context) => () {
    context.router.navigate(DetailsOfferRoute(offer: offer));
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
              Text(offer.id.toString()),
            ],
          ),
        ),
      ),
    );
  }

}