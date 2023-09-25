import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/group_model.dart';
import '../../../../data/params/dictionary/index_group_params.dart';
import '../../../../data/repositories/dictionary/dictionary_repository.dart';

part 'group_picker_state.dart';

class GroupPickerCubit extends Cubit<GroupPickerState> {
  GroupPickerCubit() : super(const GroupPickerState());

  Future fetch(IndexGroupParams params) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return DictionaryRepository.indexGroups(params).then((value) {
      replace(value, params);
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<GroupModel> groups, IndexGroupParams? params) {
    emit(state.copyWith(
        status: FetchStatus.success,
        groups: params == null || params.startRow == 0 ? groups : [...state.groups, ...groups]
    ));
  }
}
