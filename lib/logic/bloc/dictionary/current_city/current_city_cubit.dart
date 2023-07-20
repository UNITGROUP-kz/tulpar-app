import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/repositories/dictionary/city_repository.dart';

import '../../../../data/models/dictionary/city_model.dart';

part 'current_city_state.dart';

class CurrentCityCubit extends Cubit<CurrentCityState> {
  CurrentCityCubit() : super(CurrentCityState());

  initial() async {
    CityModel? city = await CityRepository.read();
    if(city != null) emit(CurrentCityState(currentCity: city));
  }

  fetch() {
    CityRepository.index().then((value) {
      emit(state.copyWith(cities: value));
    });
  }

  change(CityModel city) async {
    await CityRepository.clear();
    await CityRepository.write(city).then((value) {
      emit(state.copyWith(currentCity: city));
    });
  }
}
