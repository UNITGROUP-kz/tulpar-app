import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/error_model.dart';
import 'package:garage/data/repositories/user/offer_user_repository.dart';
import 'package:garage/data/repositories/user/order_user_repository.dart';

import '../../../../data/models/dictionary/offer_model.dart';
import '../../../../data/models/dictionary/order_model.dart';

part 'details_order_state.dart';

class DetailsOrderCubit extends Cubit<DetailsOrderState> {
  DetailsOrderCubit() : super(DetailsOrderState());


  fetch([int? orderId]) {

    if(state.status == FetchStatus.loading) return;

    if(state.order?.id == orderId) {
      emit(state.copyWith(status: FetchStatus.loading));
    } else {
      emit(const DetailsOrderState(status: FetchStatus.loading));
    }

    return OrderUserRepository.info(state.order?.id ?? orderId!).then((value) {
      emit(state.copyWith(status: FetchStatus.success, order: value));
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

  Future accept(OfferModel offer) {
    return OfferUserRepository.accept(offer).then((value) {
      fetch();
    });
  }
}
