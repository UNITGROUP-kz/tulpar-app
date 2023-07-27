import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/car_model_model.dart';
import '../../../../data/params/dictionary/index_car_model_params.dart';
import '../../../../data/repositories/dictionary/dictionary_repository.dart';

part 'car_model_state.dart';

class CarModelCubit extends Cubit<CarModelState> {
  CarModelCubit() : super(CarModelState());


  Future fetch([IndexCarModelParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return DictionaryRepository.indexCarModels(params ?? IndexCarModelParams()).then((value) {
      replace(value, params ?? IndexCarModelParams());
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<CarModelModel> carModels, IndexCarModelParams? params) {
    emit(state.copyWith(
        status: FetchStatus.success,
        params: params,
        carModels: params == null || params.startRow == 0 ? carModels : [...state.carModels, ...carModels],
    ));
  }
}
