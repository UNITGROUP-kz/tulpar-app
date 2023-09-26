import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/logic/bloc/user/my_orders/my_order_cubit.dart';
import 'package:garage/presentation/screens/picker/lat_lon_picker.dart';
import 'package:garage/presentation/widgets/buttons/elevated_button.dart';
import 'package:garage/presentation/widgets/screen_templates/screen_default_template.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../data/models/dictionary/order_model.dart';
import '../../../../logic/bloc/store/orders/orders_cubit.dart';
import '../../../routing/router.dart';
import '../../../widgets/cards/order_card.dart';
import '../../../widgets/navigation/header.dart';
import '../../../widgets/snackbars/error_snackbar.dart';

@RoutePage()
class StoreOrdersScreen extends StatefulWidget {

  @override
  State<StoreOrdersScreen> createState() => _StoreOrdersScreenState();
}

class _StoreOrdersScreenState extends State<StoreOrdersScreen> {
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
    return await context.read<StoreOrdersCubit>().fetch();
  }

  _listenerState(context, StoreOrdersState state) {
    if(state.status == FetchStatus.error) {
      showErrorSnackBar(context, state.error?.messages[0] ?? 'Неизвестная ошибка');
    }
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final state = context.read<StoreOrdersCubit>().state;

      if(state.status == FetchStatus.loading) return;

      final params = context.read<StoreOrdersCubit>().state.params;
      await context.read<StoreOrdersCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _toDetails(OrderModel order) => () {
    context.router.navigate(DetailsOrderStoreRoute(order: order));
  };

  _geoPosition(BuildContext context) => () {
    final state = context.read<StoreOrdersCubit>().state;
    LatLng? latLng;

    if(state.params?.lon != null && state.params?.lat != null) {
      latLng = LatLng(state.params!.lat!, state.params!.lon!);
    }

    showModalBottomSheet(
        useSafeArea: true,
        useRootNavigator: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) => MapSheet(callback: _searchPosition(context), latLng: latLng)
    );
  };

  _searchPosition(BuildContext context) => (LatLng latLng) async {
    context.router.pop().then((value) async {
      final state = context.read<StoreOrdersCubit>().state;

      if(state.status == FetchStatus.loading) return;

      final params = context.read<StoreOrdersCubit>().state.params;
      await context.read<StoreOrdersCubit>().fetch(params?.copyWith(
          startRow: 0,
          lat: latLng.latitude,
          lon: latLng.longitude
      ));
    });
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      scrollController: _scrollController,
      onRefresh: _onRefresh,
      children: [
        Header(
          title: 'Заказы',
          isBack: false,
          tril: GestureDetector(
              onTap: _geoPosition(context),
              child: Icon(Icons.location_on)
          ),
        ),
        BlocConsumer<StoreOrdersCubit, StoreOrdersState>(
          listener: _listenerState,
          builder: (context, state) {
            return Column(
              children: [
                ...state.orders.map((order) {
                  return OrderCard(order: order, callback: _toDetails(order));
                }).toList(),
                if(state.orders.isEmpty && state.status == FetchStatus.success) Text('Нет Заказов'),
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


class MapSheet extends StatefulWidget {
  final LatLng? latLng;
  final Function(LatLng) callback;

  const MapSheet({super.key, required this.callback, this.latLng});
  @override
  State<MapSheet> createState() => _MapSheetState();
}

class _MapSheetState extends State<MapSheet> {
  late LatLonController _controller;

  @override
  void initState() {
    _controller = LatLonController(value: widget.latLng);
    super.initState();
  }

  _onTap() {
    widget.callback(_controller.value!);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MapPicker(controller: _controller),
          SizedBox(height: 10),

          ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, child) {
                return ElevatedButtonWidget(child: Text('Искать'), onPressed: value != null? _onTap: null);
              }
          ),
        ],
      ),
    );
  }
}