part of 'my_car_cubit.dart';

class MyCarState extends Equatable {
  final List<CarModel> cars;
  final FetchStatus status;
  final IndexMyCarParams? params;

  const MyCarState({
    this.cars = const [],
    this.status = FetchStatus.initial,
    this.params
  });

  @override
  List<Object?> get props => [cars, status, params];

  MyCarState copyWith({
    List<CarModel>? cars,
    FetchStatus? status,
    IndexMyCarParams? params
  }) {
    return MyCarState(
      cars: cars ?? this.cars,
      status: status ?? this.status,
      params: params ?? this.params
    );
  }
}
