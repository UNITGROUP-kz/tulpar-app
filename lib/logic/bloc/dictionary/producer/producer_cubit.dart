import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/params/dictionary/index_producer_params.dart';
import 'package:garage/data/repositories/dictionary/producer_repository.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/dictionary/producer_model.dart';

part 'producer_state.dart';

class ProducerCubit extends Cubit<ProducerState> {
  ProducerCubit() : super(ProducerState());


  Future fetch([IndexProducerParams? params]) async {
    if(state.status == FetchStatus.loading) return;
    emit(state.copyWith(status: FetchStatus.loading));
    return ProducerRepository.index(params ?? IndexProducerParams()).then((value) {
      replace(value, params == null || params.startRow == 0);
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<ProducerModel> producers, bool isReplace) {
    emit(state.copyWith(
        status: FetchStatus.success,
        producers: isReplace ? producers : [...state.producers, ...producers]
    ));
  }
}
