part of 'change_profile_cubit.dart';

class ChangeProfileState extends Equatable {
  final FetchStatus status;
  final ErrorModel? error;

  const ChangeProfileState({
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [status, error];
}
