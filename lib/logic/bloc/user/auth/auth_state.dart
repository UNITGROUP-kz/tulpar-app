part of 'auth_cubit.dart';

enum AuthStatus {
  initial, loading, success, error, validate
}

class AuthState extends Equatable {
  final AuthModel? auth;

  UserModel? get user => auth?.user.value;

  bool get isLogin => auth != null;

  const AuthState({
    this.auth,

  });

  @override
  List<Object?> get props => [auth];

  AuthState copyWith({
    AuthModel? auth
  }) {
    return AuthState(
      auth: auth ?? this.auth
    );
  }
}

