part of 'create_car_cubit.dart';

class CreateCarState extends Equatable {
  final FetchStatus status;
  final ErrorModel? error;

  const CreateCarState({
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [status, error];
}
