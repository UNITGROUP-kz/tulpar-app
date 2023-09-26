import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/presentation/widgets/buttons/elevated_button.dart';
import 'package:garage/presentation/widgets/cards/offer_card.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:garage/presentation/widgets/snackbars/success_snackbar.dart';

import '../../../../data/models/dictionary/offer_model.dart';
import '../../../../data/models/dictionary/order_model.dart';
import '../../../../logic/bloc/user/order_offer/order_offer_cubit.dart';
import '../../../widgets/buttons/outlined_button.dart';
import '../../../widgets/navigation/header.dart';
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

  _showAccept(OfferModel offer) => () {
    showModalBottomSheet(
        useSafeArea: true,
        useRootNavigator: true,
        context: context,
        builder: (context) => AcceptModal(callback: _accept(context, offer),)
    );
  };

  _accept(BuildContext context, OfferModel offer) => () {
    context.read<OrderOfferCubit>().acceptOffer(offer).then((value) {
      print(value);
      showSuccessSnackBar(context, 'Предложение успешно принято');
    }).catchError((error) {
      print(error);

      if(error is DioException) {
        showErrorSnackBar(context, error.response?.data['message'] ?? 'Неизвестная ошибка');
      } else {
        showErrorSnackBar(context, 'Неизвестная ошибка');
      }
    }).whenComplete(() async {
      context.router.pop().then((value) {
        context.router.pop();
      });
    });
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      scrollController: _scrollController,
      onRefresh: _onRefresh,
      children: [
        Header(title: 'Предложения'),
        BlocConsumer<OrderOfferCubit, OrderOfferState>(
          listener: _listenerState,
          builder: (context, state) {
            return Column(
              children: [
                ...state.offers.map((offer) {
                  return OfferCard(offer: offer, callback: _showAccept(offer),);
                }).toList(),
                if(state.offers.isEmpty && state.status == FetchStatus.success) Text('Нет предложений'),
                if(state.status == FetchStatus.loading) CupertinoActivityIndicator(),
                if(state.status == FetchStatus.error) Text('Ошибка')

              ],
            );
          },
        )
      ],
    );
  }
}


class AcceptModal extends StatelessWidget {

  final VoidCallback callback;

  const AcceptModal({super.key, required this.callback});

  _no(BuildContext context) => () {
    context.router.pop();
  };



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Вы хотите принять это предложение?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButtonWidget(
                  child: Text('Нет'),
                  onPressed: _no(context),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButtonWidget(
                  child: Text('Да'),
                  onPressed: callback,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}