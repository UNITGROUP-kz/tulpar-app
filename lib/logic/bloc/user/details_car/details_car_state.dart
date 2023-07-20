part of 'details_car_cubit.dart';

class DetailsCarState extends Equatable {
  final List<PartModel> parts;
  final FetchStatus status;
  final ErrorModel? error;
  final IndexPartParams? params;

  const DetailsCarState({
    this.parts = const [],
    this.status = FetchStatus.initial,
    this.error,
    this.params
  });

  @override
  List<Object?> get props => [parts, status, error, params];

  DetailsCarState copyWith({
    List<PartModel>? parts,
    FetchStatus? status,
    IndexPartParams? params,
    ErrorModel? error
  }) {
    return DetailsCarState(
        parts: parts ?? this.parts,
        status: status ?? this.status,
        params: params ?? this.params,
        error: error ?? this.error
    );
  }
}
