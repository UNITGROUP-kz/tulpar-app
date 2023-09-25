part of 'producer_cubit.dart';

class ProducerState extends Equatable {
  final List<ProducerModel> producers;
  final List<ProducerModel> popular;
  final List<String> letter;

  final IndexProducerParams? params;
  final FetchStatus status;


  const ProducerState({
    this.producers = const [],
    this.popular = const [],
    this.letter = const [],
    this.params,
    this.status = FetchStatus.initial
  });

  @override
  List<Object?> get props => [producers, params, status, popular, letter];


  ProducerState copyWith({
    List<ProducerModel>? producers,
    List<ProducerModel>? popular,
    List<String>? letter,
    FetchStatus? status,
    IndexProducerParams? params,
  }) {
    return ProducerState(
        producers: producers ?? this.producers,
        popular: popular ?? this.popular,
        status: status ?? this.status,
        params: params ?? this.params,
        letter: letter ?? this.letter
    );
  }
}

