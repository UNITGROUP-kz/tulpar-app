import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../../data/models/dictionary/offer_model.dart';

@RoutePage()
class DetailsOfferScreen extends StatefulWidget {

  final OfferModel offer;

  const DetailsOfferScreen({super.key, required this.offer});

  @override
  State<DetailsOfferScreen> createState() => _DetailsOfferScreenState();
}

class _DetailsOfferScreenState extends State<DetailsOfferScreen> {
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

  _back() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    print('Details Offer');
    return Stack(
      children: [
        ScreenDefaultTemplate(
          scrollController: _scrollController,
          children: [
            Text(widget.offer.id.toString())
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: IconButton(onPressed: _back, icon: Icon(Icons.arrow_back_ios)),
        ),
      ],
    );
  }
}