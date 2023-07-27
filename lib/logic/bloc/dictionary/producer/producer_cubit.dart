import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/params/dictionary/index_producer_params.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/producer_model.dart';
import '../../../../data/repositories/dictionary/dictionary_repository.dart';

part 'producer_state.dart';

class ProducerCubit extends Cubit<ProducerState> {
  ProducerCubit() : super(ProducerState());


  Future fetch([IndexProducerParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return DictionaryRepository.indexProducers(params ?? IndexProducerParams()).then((value) {
      replace(value, params ?? IndexProducerParams());
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<ProducerModel> producers, IndexProducerParams? params) {
    emit(state.copyWith(
        status: FetchStatus.success,
        params: params,
        producers: params == null || params.startRow == 0 ? producers : [...state.producers, ...producers]
    ));
  }
}
