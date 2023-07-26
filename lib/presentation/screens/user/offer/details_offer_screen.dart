import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../../data/models/dictionary/offer_model.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/navigation/header.dart';

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

  _accept() {

  }

  @override
  Widget build(BuildContext context) {
    print('Details Offer');
    return ScreenDefaultTemplate(
      scrollController: _scrollController,
      children: [
        Header(title: 'Предложение'),
        Text(widget.offer.id.toString()),
        ElevatedButtonWidget(onPressed: _accept, child: Text('Accept'))
      ],
    );
  }
}