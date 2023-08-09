part of 'support_cubit.dart';

class SupportState extends Equatable {
  final FetchStatus status;
  final ErrorModel? error;

  const SupportState({
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [status, error];
}