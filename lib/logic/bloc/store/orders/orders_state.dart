part of 'orders_cubit.dart';

class StoreOrdersState extends Equatable {
  final List<OrderModel> orders;
  final FetchStatus status;
  final IndexOrderParams? params;
  final ErrorModel? error;

  const StoreOrdersState({
    this.orders = const [],
    this.status = FetchStatus.initial,
    this.params,
    this.error
  });

  @override
  List<Object?> get props => [orders, status, params, error];

  StoreOrdersState copyWith({
    List<OrderModel>? orders,
    FetchStatus? status,
    IndexOrderParams? params,
    ErrorModel? error
  }) {
    return StoreOrdersState(
        orders: orders ?? this.orders,
        status: status ?? this.status,
        params: params ?? this.params,
        error: error ?? this.error
    );
  }
}
