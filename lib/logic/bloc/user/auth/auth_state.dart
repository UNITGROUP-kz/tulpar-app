part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthModel? auth;
  final bool isLoading;
  final ErrorModel? error;

  UserModel? get user => auth?.user.value;

  const AuthState({
    this.auth,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [auth, isLoading, error];

  AuthState copyWith({
    AuthModel? auth,
    bool? isLoading,
    ErrorModel? error
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error
    );
  }
}

