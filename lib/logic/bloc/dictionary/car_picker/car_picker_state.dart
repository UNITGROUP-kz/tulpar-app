part of 'car_picker_cubit.dart';

class CarPickerState extends Equatable {
  final List<CarApiModel> cars;
  final FetchStatus status;

  CarPickerState({
    this.cars = const [],
    this.status = FetchStatus.initial
  });

  @override
  List<Object?> get props => [cars, status];

  CarPickerState copyWith({
    List<CarApiModel>? cars,
    FetchStatus? status,
  }) {
    return CarPickerState(
      cars: cars ?? this.cars,
      status: status ?? this.status,
    );
  }
}