part of 'producer_cubit.dart';

class ProducerState extends Equatable {
  final List<ProducerModel> producers;
  final IndexProducerParams? params;
  final FetchStatus status;


  const ProducerState({
    this.producers = const [],
    this.params,
    this.status = FetchStatus.initial
  });

  @override
  List<Object?> get props => [producers, params, status];


  ProducerState copyWith({
    List<ProducerModel>? producers,
    FetchStatus? status,
    IndexProducerParams? params
  }) {
    return ProducerState(
        producers: producers ?? this.producers,
        status: status ?? this.status,
        params: params ?? this.params
    );
  }
}

