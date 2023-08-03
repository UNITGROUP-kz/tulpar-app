part of 'login_store_cubit.dart';

class LoginStoreState extends Equatable {

  final ErrorModel? error;
  final FetchStatus status;

  const LoginStoreState({
    this.error,
    this.status = FetchStatus.initial
  });

  @override
  List<Object?> get props => [status, error];


  LoginStoreState copyWith({
    FetchStatus? status,
    ErrorModel? error
  }) {
    return LoginStoreState(
        status: status ?? this.status,
        error: error ?? this.error
    );
  }
}

