
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/presentation/routing/router.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/order_model.dart';
import '../../../../logic/bloc/user/details_order/details_order_cubit.dart';
import '../../../widgets/buttons/elevated_button.dart';
import '../../../widgets/cards/car_card.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/screen_templates/screen_default_template.dart';
import '../../../widgets/snackbars/success_snackbar.dart';
import '../../../widgets/tiles/data_tile.dart';

@RoutePage()
class DetailsOrderStoreScreen extends StatefulWidget {

  final OrderModel order;

  const DetailsOrderStoreScreen({super.key, required this.order});

  @override
  State<DetailsOrderStoreScreen> createState() => _DetailsOrderStoreScreenState();
}

class _DetailsOrderStoreScreenState extends State<DetailsOrderStoreScreen> {
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

  _listener(BuildContext context, DetailsOrderState state) {
    if(state.status == FetchStatus.error) {
      showSuccessSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  _createOffer() {
    context.router.navigate(SplashRouter(
      children: [
        StoreFormRouter(
            children: [CreateOfferRoute(order: widget.order)]
        )
      ]
    ));
  }


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
                        car: state.order!.car!
                    ),
                    Text(state.order?.title ?? 'Заголовок', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    DataTile(title: 'Город', data: state.order!.city?.name),
                    DataTile(title: 'Запчасть', data: state.order!.part?.name),
                    SizedBox(height: 20),
                    if(state.order!.comment != null) ...[
                      Text('Описание', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      Text(state.order!.comment!, style: TextStyle(fontSize: 17),),
                    ],

                    if(widget.order.status == OrderStatus.active && state.order?.store == null) ...[
                      SizedBox(height: 20),
                      ElevatedButtonWidget(onPressed: _createOffer, child: Text('Создать предложения'))
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