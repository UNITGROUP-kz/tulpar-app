part of 'order_offer_cubit.dart';

class OrderOfferState extends Equatable {
  final List<OfferModel> offers;
  final FetchStatus status;
  final ErrorModel? error;

  const OrderOfferState({
    this.offers = const [],
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [offers, status, error];

  OrderOfferState copyWith({
    List<OfferModel>? offers,
    FetchStatus? status,
    IndexOfferParams? params,
    ErrorModel? error
  }) {
    return OrderOfferState(
        offers: offers ?? this.offers,
        status: status ?? this.status,
        error: error ?? this.error
    );
  }
}

class OrderOfferInitial extends OrderOfferState {
  @override
  List<Object> get props => [];
}
