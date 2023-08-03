part of 'change_image_cubit.dart';

class ChangeImageUserState extends Equatable {
  final Uint8List? bytes;
  final FetchStatus status;
  final ErrorModel? error;
  
  const ChangeImageUserState({
    this.bytes,
    this.error,
    this.status = FetchStatus.initial
  });
  
  ChangeImageUserState copyWith({
    Uint8List? bytes,
    FetchStatus? status,
    ErrorModel? error
  }) {
    return ChangeImageUserState(
      bytes: bytes ?? this.bytes,
      status: status ?? this.status,
      error:  error ?? this.error
    );
  }

  @override
  List<Object?> get props => [bytes, status, error];
}

