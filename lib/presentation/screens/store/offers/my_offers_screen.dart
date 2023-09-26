import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/presentation/routing/router.dart';
import 'package:garage/presentation/widgets/cards/offer_card.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';

import '../../../../data/models/dictionary/offer_model.dart';
import '../../../../logic/bloc/store/my_offers/my_offers_cubit.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/snackbars/error_snackbar.dart';

@RoutePage()
class MyOffersScreen extends StatefulWidget {

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _onRefresh();
    _scrollController = ScrollController()..addListener(_listenerScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listenerScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future _onRefresh() async {
    return await context.read<MyOffersCubit>().fetch();
  }

  _listenerState(context, MyOffersState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final state = context.read<MyOffersCubit>().state;

      if(state.status != FetchStatus.loading) return;

      final params = context.read<MyOffersCubit>().state.params;
      await context.read<MyOffersCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _onTap(OfferModel offer) => () {
    context.router.navigate(SplashRouter(
      children: [
        StoreRouter(
          children: [
            StoreOfferRouter(
              children: [
                DetailsOfferStoreRoute(offer: offer)
              ]
            )
          ]
        )
      ]
    ));
  };


  @override
  Widget build(BuildContext context) {
    print('my-offers');
    return ScreenDefaultTemplate(
      scrollController: _scrollController,
      onRefresh: _onRefresh,
      children: [
        Header(title: 'Предложения', isBack: false),
        BlocConsumer<MyOffersCubit, MyOffersState>(
          listener: _listenerState,
          builder: (context, state) {
            return Column(
              children: [
                ...state.offers.map((offer) {
                  return OfferCard(offer: offer, callback: _onTap(offer));
                }).toList(),
                if(state.offers.isEmpty && state.status == FetchStatus.success) Text('Нет Предложений'),
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
