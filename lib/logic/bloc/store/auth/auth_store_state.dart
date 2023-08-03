part of 'auth_store_cubit.dart';

class AuthStoreState extends Equatable {
  final AuthStoreModel? auth;

  StoreModel? get store => auth?.store.value;

  bool get isLogin => auth != null;


  const AuthStoreState({
    this.auth,
  });

  @override
  List<Object?> get props => [auth, store, isLogin];

  AuthStoreState copyWith({
    AuthStoreModel? auth,
  }) {
    return AuthStoreState(
        auth: auth ?? this.auth,
    );
  }
}
