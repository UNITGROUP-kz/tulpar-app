import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/details_order/details_order_cubit.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/tiles/data_tile.dart';

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
    final orderCubit = context.read<DetailsOrderCubit>();
    if(orderCubit.state.order == null) return;

    orderCubit.accept(widget.offer).then((value) {
      context.router.navigate(
        SplashRouter(
          children: [
            UserRouter(
              children: [
                UserOrderRouter(
                  children: [
                    DetailsOrderRoute(order: orderCubit.state.order!)
                  ]
                )
              ]
            )
          ]
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Details Offer');
    return ScreenDefaultTemplate(
      scrollController: _scrollController,
      children: [
        Header(title: 'Предложение'),
        Text(widget.offer.id.toString()),
        DataTile(title: 'Производитель', data: widget.offer.producer),
        DataTile(title: 'Доставка', data: widget.offer.delivery),
        DataTile(title: 'Цена', data: '${widget.offer.price} тг'),
        DataTile(title: 'Состояние', data: widget.offer.condition.toString()),


        ElevatedButtonWidget(onPressed: _accept, child: Text('Accept'))
      ],
    );
  }
}