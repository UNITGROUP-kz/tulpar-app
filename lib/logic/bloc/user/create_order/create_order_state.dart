part of 'create_order_cubit.dart';

class CreateOrderState extends Equatable {
  final FetchStatus status;
  final ErrorModel? error;

  const CreateOrderState({
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [status, error];
}

