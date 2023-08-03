part of 'change_image_cubit.dart';

class ChangeImageStoreState extends Equatable {
  final Uint8List? bytes;
  final FetchStatus status;
  final ErrorModel? error;
  
  const ChangeImageStoreState({
    this.bytes,
    this.error,
    this.status = FetchStatus.initial
  });
  
  ChangeImageStoreState copyWith({
    Uint8List? bytes,
    FetchStatus? status,
    ErrorModel? error
  }) {
    return ChangeImageStoreState(
      bytes: bytes ?? this.bytes,
      status: status ?? this.status,
      error:  error ?? this.error
    );
  }

  @override
  List<Object?> get props => [bytes, status, error];
}

