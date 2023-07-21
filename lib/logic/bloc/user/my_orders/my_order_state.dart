part of 'my_order_cubit.dart';

class MyOrderState extends Equatable {
  final List<OrderModel> orders;
  final FetchStatus status;
  final IndexOrderParams? params;
  final ErrorModel? error;

  const MyOrderState({
    this.orders = const [],
    this.status = FetchStatus.initial,
    this.params,
    this.error
  });

  @override
  List<Object?> get props => [orders, status, params, error];

  MyOrderState copyWith({
    List<OrderModel>? orders,
    FetchStatus? status,
    IndexOrderParams? params,
    ErrorModel? error
  }) {
    return MyOrderState(
        orders: orders ?? this.orders,
        status: status ?? this.status,
        params: params ?? this.params,
        error: error ?? this.error
    );
  }
}
