part of 'current_city_cubit.dart';

class CurrentCityState extends Equatable {
  final CityModel? currentCity;
  final List<CityModel> cities;
  final FetchStatus status;
  final IndexCityParams? params;

  const CurrentCityState({
    this.currentCity,
    this.cities = const [],
    this.status = FetchStatus.initial,
    this.params,
  });

  @override
  List<Object?> get props => [currentCity, cities, status, params];

  CurrentCityState copyWith({
    CityModel? currentCity,
    List<CityModel>? cities,
    FetchStatus? status,
    IndexCityParams? params
  }) {
    return CurrentCityState(
        currentCity: currentCity ?? this.currentCity,
        cities: cities ?? this.cities,
        status: status ?? this.status,
        params: params ?? this.params
    );
  }
}
