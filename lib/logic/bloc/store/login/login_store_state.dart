part of 'login_store_cubit.dart';

class LoginStoreState extends Equatable {

  final ErrorModel? error;
  final FetchStatus status;
  final AuthStoreModel? auth;

  const LoginStoreState({
    this.error,
    this.status = FetchStatus.initial,
    this.auth,
  });

  @override
  List<Object?> get props => [status, error, auth];


  LoginStoreState copyWith({
    FetchStatus? status,
    ErrorModel? error,
    AuthStoreModel? auth
  }) {
    return LoginStoreState(
        status: status ?? this.status,
        error: error ?? this.error,
        auth: auth ?? this.auth
    );
  }
}

