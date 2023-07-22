part of 'auth_store_cubit.dart';

class AuthStoreState extends Equatable {
  final AuthStoreModel? auth;
  final bool isLoading;
  final ErrorModel? error;

  StoreModel? get store => auth?.store.value;

  const AuthStoreState({
    this.auth,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [auth, isLoading, error];

  AuthStoreState copyWith({
    AuthStoreModel? auth,
    bool? isLoading,
    ErrorModel? error
  }) {
    return AuthStoreState(
        auth: auth ?? this.auth,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error
    );
  }
}
