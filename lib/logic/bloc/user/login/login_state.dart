part of 'login_cubit.dart';

enum LoginStatus {
  initial, loading, success, error, validate
}

class LoginState extends Equatable {

  final ErrorModel? error;
  final LoginStatus status;

  const LoginState({
    this.error,
    this.status = LoginStatus.initial
  });

  @override
  List<Object?> get props => [status, error];


  LoginState copyWith({
    LoginStatus? status,
    ErrorModel? error
  }) {
    return LoginState(
        status: status ?? this.status,
        error: error ?? this.error
    );
  }
}
