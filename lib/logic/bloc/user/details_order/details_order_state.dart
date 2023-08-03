part of 'details_order_cubit.dart';

class DetailsOrderState extends Equatable {
  final OrderModel? order;
  final FetchStatus status;
  final ErrorModel? error;


  const DetailsOrderState({
    this.order,
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [order, status, error];

  DetailsOrderState copyWith({
    OrderModel? order,
    FetchStatus? status,
    ErrorModel? error
  }) {
    return DetailsOrderState(
      order: order ?? this.order,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }
}
