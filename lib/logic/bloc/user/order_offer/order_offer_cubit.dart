import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/dictionary/offer_model.dart';
import 'package:garage/data/models/dictionary/order_model.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';
import '../../../../data/params/offers/index_offer_params.dart';
import '../../../../data/repositories/user/offer_user_repository.dart';
import '../auth/auth_cubit.dart';

part 'order_offer_state.dart';

class OrderOfferCubit extends Cubit<OrderOfferState> {
  final AuthCubit authCubit;
  OrderOfferCubit(this.authCubit) : super(OrderOfferState());

  Future fetch(OrderModel order) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return OfferUserRepository.index(order).then((value) {
      replace(value, true);
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

  replace(List<OfferModel> orders, bool isReplace) {
    emit(state.copyWith(
        status: FetchStatus.success,
        offers: isReplace ? orders : [...state.offers, ...orders]
    ));
  }
}
