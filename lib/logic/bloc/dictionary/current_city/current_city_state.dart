part of 'current_city_cubit.dart';

class CurrentCityState extends Equatable {
  final CityModel? currentCity;
  final List<CityModel> cities;

  const CurrentCityState({
    this.currentCity,
    this.cities = const [],
  });

  @override
  List<Object?> get props => [currentCity, cities];

  CurrentCityState copyWith({
    CityModel? currentCity,
    List<CityModel>? cities
  }) {
    return CurrentCityState(
        currentCity: currentCity ?? this.currentCity,
        cities: cities ?? this.cities
    );
  }
}
