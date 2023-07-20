import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/params/car/index_car_params.dart';
import 'package:garage/data/repositories/user/car_user_repository.dart';

part 'my_car_state.dart';

class MyCarCubit extends Cubit<MyCarState> {
  MyCarCubit() : super(MyCarState());

  Future fetch([IndexMyCarParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return CarUserRepository.indexMy(params ?? IndexMyCarParams()).then((value) {
      replace(value, params == null || params.startRow == 0);
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<CarModel> cars, bool isReplace) {
    emit(state.copyWith(
      status: FetchStatus.success,
      cars: isReplace ? cars : [...state.cars, ...cars]
    ));
  }
}
