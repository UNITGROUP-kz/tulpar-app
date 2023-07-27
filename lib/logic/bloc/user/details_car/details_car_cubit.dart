import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/data/repositories/dictionary/dictionary_repository.dart';

import '../../../../data/models/error_model.dart';
import '../../../../data/params/dictionary/index_part_params.dart';

part 'details_car_state.dart';

class DetailsCarCubit extends Cubit<DetailsCarState> {
  DetailsCarCubit() : super(DetailsCarState());

  Future fetch([IndexPartParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));

    print('params: ${params?.toData()}');
    return DictionaryRepository.indexParts(params ?? IndexPartParams()).then((value) {
      print(value);
      replace(value, params ?? IndexPartParams());
    }).catchError((error) {
      print(error);
      emit(state.copyWith(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }

  replace(List<PartModel> parts, IndexPartParams? params) {
    emit(state.copyWith(
        status: FetchStatus.success,
        params: params,
        parts: params == null || params.startRow == 0 ? parts : [...state.parts, ...parts]
    ));
  }
}
