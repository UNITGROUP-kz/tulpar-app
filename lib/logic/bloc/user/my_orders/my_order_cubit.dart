import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/dictionary/order_model.dart';
import 'package:garage/data/params/order/index_order_params.dart';
import 'package:garage/data/repositories/user/order_user_repository.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';
import '../auth/auth_cubit.dart';

part 'my_order_state.dart';

class MyOrderCubit extends Cubit<MyOrderState> {
  final AuthCubit authCubit;

  MyOrderCubit(this.authCubit) : super(MyOrderState());

  Future fetch([IndexOrderParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return OrderUserRepository.indexMy(params ?? IndexOrderParams()).then((value) {
      replace(value, params == null || params.startRow == 0);
    }).catchError((error) {
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
