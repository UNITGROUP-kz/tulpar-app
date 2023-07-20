part of 'my_car_cubit.dart';

class MyCarState extends Equatable {
  final List<CarModel> cars;
  final FetchStatus status;
  final IndexMyCarParams? params;
  final ErrorModel? error;

  const MyCarState({
    this.cars = const [],
    this.status = FetchStatus.initial,
    this.params,
    this.error
  });

  @override
  List<Object?> get props => [cars, status, params, error];

  MyCarState copyWith({
    List<CarModel>? cars,
    FetchStatus? status,
    IndexMyCarParams? params,
    ErrorModel? error
  }) {
    return MyCarState(
      cars: cars ?? this.cars,
      status: status ?? this.status,
      params: params ?? this.params,
      error: error ?? this.error
    );
  }
}
