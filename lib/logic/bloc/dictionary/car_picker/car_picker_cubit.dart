import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/models/dictionary/car_api_model.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/data/models/dictionary/producer_model.dart';
import 'package:garage/data/params/car/index_car_params.dart';
import 'package:garage/data/repositories/user/car_user_repository.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/repositories/dictionary/dictionary_repository.dart';

part 'car_picker_state.dart';

class CarPickerCubit extends Cubit<CarPickerState> {
  CarPickerCubit() : super(CarPickerState());

  Future fetch({
    required ProducerModel producer,
    required CarModelModel carModel
  }) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return DictionaryRepository.indexCar(GetCarParams(producer: producer, carModel: carModel)).then((value) {
      replace(value);
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<CarApiModel> cars) {
    emit(state.copyWith(
        status: FetchStatus.success,
        cars: cars
    ));
  }
}
