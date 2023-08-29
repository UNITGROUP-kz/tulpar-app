part of 'login_store_cubit.dart';

class LoginStoreState extends Equatable {

  final ErrorModel? error;
  final FetchStatus status;
  final StoreCategoryModel? category;

  const LoginStoreState({
    this.error,
    this.status = FetchStatus.initial,
    this.category,
  });

  @override
  List<Object?> get props => [status, error];


  LoginStoreState copyWith({
    FetchStatus? status,
    ErrorModel? error,
    StoreCategoryModel? category
  }) {
    return LoginStoreState(
        status: status ?? this.status,
        error: error ?? this.error,
        category: category ?? this.category
    );
  }
}

