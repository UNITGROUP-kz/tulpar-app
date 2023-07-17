part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthModel? auth;
  final bool isLoading;

  UserModel? get user => auth?.user.value;

  const AuthState({
    this.auth,
    this.isLoading = false
  });

  @override
  List<Object?> get props => [auth, isLoading];

  AuthState copyWith({
    AuthModel? auth,
    bool? isLoading
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      isLoading: isLoading ?? this.isLoading
    );
  }
}

