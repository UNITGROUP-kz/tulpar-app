import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/logic/bloc/user/my_orders/my_order_cubit.dart';
import 'package:garage/presentation/widgets/cards/offer_card.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../../data/models/dictionary/order_model.dart';
import '../../../../logic/bloc/user/order_offer/order_offer_cubit.dart';
import '../../../widgets/cards/order_card.dart';
import '../../../widgets/snackbars/error_snackbar.dart';

@RoutePage()
class OrderOffersScreen extends StatefulWidget {

  final OrderModel order;

  const OrderOffersScreen({super.key, required this.order});

  @override
  State<OrderOffersScreen> createState() => _OrderOffersScreenState();
}

class _OrderOffersScreenState extends State<OrderOffersScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _onRefresh();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future _onRefresh() async {
    return await context.read<OrderOfferCubit>().fetch(widget.order);
  }

  _listenerState(context, OrderOfferState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  _back() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScreenDefaultTemplate(
          scrollController: _scrollController,
          onRefresh: _onRefresh,
          children: [
            BlocConsumer<OrderOfferCubit, OrderOfferState>(
              listener: _listenerState,
              builder: (context, state) {
                return Column(
                  children: [
                    ...state.offers.map((offer) {
                      return OfferCard(offer: offer);
                    }).toList(),
                    if(state.offers.isEmpty) Text('Нет предложений'),
                    if(state.status == FetchStatus.loading) CupertinoActivityIndicator(),
                    if(state.status == FetchStatus.error) Text('Ошибка')

                  ],
                );
              },
            )
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
