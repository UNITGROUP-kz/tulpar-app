part of 'my_offers_cubit.dart';

class MyOffersState extends Equatable {
  final List<OfferModel> offers;
  final FetchStatus status;
  final IndexOfferParams? params;
  final ErrorModel? error;

  const MyOffersState({
    this.offers = const [],
    this.status = FetchStatus.initial,
    this.params,
    this.error
  });

  @override
  List<Object?> get props => [offers, status, params, error];

  MyOffersState copyWith({
    List<OfferModel>? offers,
    FetchStatus? status,
    IndexOfferParams? params,
    ErrorModel? error
  }) {
    return MyOffersState(
        offers: offers ?? this.offers,
        status: status ?? this.status,
        params: params ?? this.params,
        error: error ?? this.error
    );
  }
}
