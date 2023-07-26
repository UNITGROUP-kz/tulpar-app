
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/navigation/header.dart';
import '../../widgets/screen_templates/screen_default_template.dart';

@RoutePage()
class ContractOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header()
      ],
    );
  }
}