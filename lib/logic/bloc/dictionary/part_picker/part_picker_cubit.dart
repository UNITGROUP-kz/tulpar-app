import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/part_model.dart';
import '../../../../data/params/dictionary/index_part_params.dart';
import '../../../../data/repositories/dictionary/dictionary_repository.dart';

part 'part_picker_state.dart';

class PartPickerCubit extends Cubit<PartPickerState> {
  PartPickerCubit() : super(const PartPickerState());

  Future fetch(IndexPartParams params) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return DictionaryRepository.indexParts(params).then((value) {
      replace(value, params);
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<PartModel> parts, IndexPartParams? params) {
    emit(state.copyWith(
        status: FetchStatus.success,
        parts: params == null || params.startRow == 0 ? parts : [...state.parts, ...parts]
    ));
  }
}
