import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/presentation/widgets/snackbars/error_snackbar.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/auth/store_model.dart';
import '../../../../data/models/dictionary/order_model.dart';
import '../../../../logic/bloc/user/details_order/details_order_cubit.dart';
import '../../../routing/router.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/cards/car_card.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/screen_templates/screen_default_template.dart';
import '../../../widgets/snackbars/success_snackbar.dart';
import '../../../widgets/tiles/data_tile.dart';
import '../../../widgets/tiles/store_tile.dart';

@RoutePage()
class DetailsOrderScreen extends StatefulWidget {

  final OrderModel order;

  const DetailsOrderScreen({super.key, required this.order});

  @override
  State<DetailsOrderScreen> createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _fetch();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future _fetch() async {
    await context.read<DetailsOrderCubit>().fetch(widget.order.id);
  }

  _toOffers(OrderModel order) => () {
    context.router.navigate(
      OrderOffersRoute(order: order)
    );
  };

  _toRate(OrderModel order) => () {
    context.router.push(SplashRouter(
      children: [
        UserFormRouter(
          children: [
            RateOrderRoute(order: order)
          ]
        )
      ]
    ));
  };

  _listener(BuildContext context, DetailsOrderState state) {
    if(state.status == FetchStatus.error) {
      showSuccessSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  // _complete() {
  //   context.read<DetailsOrderCubit>().complete(widget.order.id).then((value) {
  //     _toRate();
  //   }).catchError((error) {
  //     print(error);
  //     if(error is DioException) {
  //       showErrorSnackBar(context, error.response?.data['message'] ?? 'Неизвестная ошибка');
  //     } else {
  //       showErrorSnackBar(context, 'Неизвестная ошибка');
  //     }
  //   });
  // }

  _toStore(StoreModel store) => () {
    context.router.navigate(SplashRouter(
      children: [
        UserRouter(
          children: [
            UserOrderRouter(
              children: [
                StoreRoute(store: store)
              ]
            )
          ]
        )
      ]
    ));
  };

  @override
  Widget build(BuildContext context) {
    print('Details Order');
    return ScreenDefaultTemplate(
      onRefresh: _fetch,
      scrollController: _scrollController,
      children: [
        Header(title: 'Заказ'),
        BlocConsumer<DetailsOrderCubit, DetailsOrderState>(
          listener: _listener,
          builder: (context, state) {
            return Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(state.status == FetchStatus.loading) Center(child:  CupertinoActivityIndicator(),),
                  if(state.order != null) ...[
                    if(state.order?.car != null) CarCard(
                        car: state.order!.car!,
                        isMy: true,
                    ),
                    SizedBox(height: 10),

                    Text(state.order?.title ?? 'Заголовок', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    DataTile(title: 'Город', data: state.order!.city?.name),
                    DataTile(title: 'Запчасть', data: state.order!.part?.name),
                    SizedBox(height: 20),
                    if(state.order!.comment != null) ...[
                      Text('Описание', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      Text(state.order!.comment!, style: TextStyle(fontSize: 17),),
                    ],
                    if(state.order?.store != null)  ...[
                      SizedBox(height: 10),
                      Text('Исполнитель заказа: ', style: TextStyle(fontSize: 17),),
                      SizedBox(height: 5),
                      StoreTile(store: state.order!.store!, callback: _toStore(state.order!.store!)),
                    ],
                    if(state.order?.status == OrderStatus.active) ...[
                      SizedBox(height: 20),
                      ElevatedButtonWidget(onPressed: _toOffers(state.order!), child: Text('Предложения'))
                    ],
                    if(state.order?.status == OrderStatus.done && state.order?.store != null) ...[
                      SizedBox(height: 20),
                      ElevatedButtonWidget(onPressed: _toRate(state.order!), child: Text('Оценить'))
                    ],
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}