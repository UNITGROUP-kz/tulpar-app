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
    emit(state.copyWith(
        status: FetchStatus.loading,
        producers: params?.startRow == 0 ? [] : null,
        popular: params?.startRow == 0 ? [] : null
      )
    );
    return Future.wait([
      DictionaryRepository.indexProducers(params ?? IndexProducerParams()),
      DictionaryRepository.indexProducers(params?.copyWith(isPopular: true) ?? IndexProducerParams().copyWith(isPopular: true))
    ]).then((value) {
      replace(value[0], value[1], params ?? IndexProducerParams());
    }).catchError((error) {
      emit(state.copyWith(status: FetchStatus.error));
    });
  }

  replace(List<ProducerModel> producers, List<ProducerModel> popular, IndexProducerParams? params) {
    List<String> letter = [];

    if(producers.isNotEmpty) {
      letter.add(producers[0].name[0].toUpperCase());
      for (var element in producers) {
        if(letter.last.toUpperCase() != element.name[0].toUpperCase()) {
          letter.add(element.name[0].toUpperCase());
        }
      }
    }

    emit(state.copyWith(
        status: FetchStatus.success,
        params: params,
        letter: letter,
        popular: params == null || params.startRow == 0 ? popular : [...state.popular, ...popular],
        producers: params == null || params.startRow == 0 ? producers : [...state.producers, ...producers]
    ));
  }
}
