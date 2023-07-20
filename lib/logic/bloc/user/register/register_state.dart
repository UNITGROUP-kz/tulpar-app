part of 'register_cubit.dart';

enum RegisterStatusState {
  register, verify, success,
}

class RegisterState extends Equatable {
  final bool isLoading;
  final ErrorModel? error;
  final RegisterStatusState status;

  const RegisterState({
    this.isLoading = false,
    this.error,
    this.status = RegisterStatusState.register
  });

  @override
  List<Object?> get props => [isLoading, error, status];

  RegisterState copyWith({
    bool? isLoading,
    ErrorModel? error,
    RegisterStatusState? status
  }) {
    return RegisterState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        status: status ?? this.status

    );
  }
}

