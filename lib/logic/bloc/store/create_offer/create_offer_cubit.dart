import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/repositories/store/offer_store_repository.dart';
import 'package:garage/logic/bloc/store/my_offers/my_offers_cubit.dart';
import 'package:garage/logic/bloc/user/my_orders/my_order_cubit.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';
import '../../../../data/params/offers/create_offer_params.dart';

part 'create_offer_state.dart';

class CreateOfferCubit extends Cubit<CreateOfferState> {
  final MyOffersCubit myOfferCubit;

  CreateOfferCubit(this.myOfferCubit) : super(CreateOfferState());
  
  
  create(CreateOfferParams params) {
    if(state.status == FetchStatus.loading) return;
    emit(CreateOfferState(status: FetchStatus.loading));
    OfferStoreRepository.create(params).then((value) {
      print(value);
      myOfferCubit.fetch();
      emit(CreateOfferState(status: FetchStatus.success));
    }).catchError((error) {
      print(error);
      emit(CreateOfferState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }
}
