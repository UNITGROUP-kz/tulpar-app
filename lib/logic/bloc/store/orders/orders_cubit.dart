import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/dictionary/order_model.dart';
import 'package:garage/data/params/order/index_order_params.dart';
import 'package:garage/data/repositories/store/order_store_repository.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';
import '../auth/auth_store_cubit.dart';

part 'orders_state.dart';

class StoreOrdersCubit extends Cubit<StoreOrdersState> {
  final AuthStoreCubit authCubit;

  StoreOrdersCubit(this.authCubit) : super(StoreOrdersState());

  Future fetch([IndexOrderParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return OrderStoreRepository.index(params ?? IndexOrderParams()).then((value) {
      print(value);
      replace(value, params == null || params.startRow == 0);
    }).catchError((error) {
      if(error is DioException) {
        if(error.response?.statusCode == 403) {
          authCubit.logout();
          emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
        }
      }
      emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

  replace(List<OrderModel> orders, bool isReplace) {
    emit(state.copyWith(
        status: FetchStatus.success,
        orders: isReplace ? orders : [...state.orders, ...orders]
    ));
  }
}
