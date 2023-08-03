import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/navigation/header.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../widgets/tiles/document_tile.dart';


@RoutePage()
class DocumentsScreen extends StatelessWidget {

  _toPrivacy(BuildContext context) => () {
    context.router.navigate(PrivacyRoute());
  };

  _toContractOffer(BuildContext context) => () {
    context.router.navigate(ContractOfferRoute());
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Документы'),
        DocumentTile(title: 'Политика конфиденциальности', callback: _toPrivacy(context)),
        DocumentTile(title: 'Договор офферты', callback: _toContractOffer(context)),
      ],
    );
  }
}

@RoutePage(name: 'DocumentRouter')
class DocumentSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: AutoRouter()),
    );
  }

}