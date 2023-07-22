part of 'change_store_cubit.dart';

class ChangeStoreState extends Equatable {
  final FetchStatus status;
  final ErrorModel? error;

  const ChangeStoreState({
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [status, error];
}
