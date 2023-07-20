part of 'car_model_cubit.dart';

class CarModelState extends Equatable {
  final List<CarModelModel> carModels;
  final IndexCarModelParams? params;
  final FetchStatus status;


  const CarModelState({
    this.carModels = const [],
    this.params,
    this.status = FetchStatus.initial
  });

  @override
  List<Object?> get props => [carModels, params, status];


  CarModelState copyWith({
    List<CarModelModel>? carModels,
    FetchStatus? status,
    IndexCarModelParams? params
  }) {
    return CarModelState(
        carModels: carModels ?? this.carModels,
        status: status ?? this.status,
        params: params ?? this.params
    );
  }
}
