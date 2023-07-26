import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/repositories/dictionary/city_repository.dart';

import '../../../../data/models/dictionary/city_model.dart';
import '../../../../data/params/dictionary/index_city_params.dart';
import '../../user/auth/auth_cubit.dart';

part 'current_city_state.dart';

class CurrentCityCubit extends Cubit<CurrentCityState> {
  final AuthCubit authCubit;
  CurrentCityCubit(this.authCubit) : super(CurrentCityState()) {
    authCubit.stream.listen(listenerAuth);

  }

  listenerAuth(AuthState state) {
    if(!state.isLogin) {
      CityRepository.clear().then((value) {
        emit(CurrentCityState());
      });
    }
  }

  initial() async {
    CityModel? city = await CityRepository.read();
    if(city != null) emit(CurrentCityState(currentCity: city));
  }

  Future fetch([IndexCityParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return CityRepository.index(params ?? IndexCityParams()).then((value) {
      print(value);
      replace(value, params);
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<CityModel> cities, IndexCityParams? params) {
    emit(state.copyWith(
        status: FetchStatus.success,
        params: params,
        cities: params == null || params.startRow == 0 ? cities : [...state.cities, ...cities]
    ));
  }

  change(CityModel city) async {
    await CityRepository.clear();
    await CityRepository.write(city).then((value) {
      emit(state.copyWith(currentCity: city));
    });
  }
}
