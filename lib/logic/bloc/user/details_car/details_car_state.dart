part of 'details_car_cubit.dart';

class DetailsCarState extends Equatable {
  final List<GroupModel> groups;
  final FetchStatus status;
  final ErrorModel? error;
  final IndexGroupParams? params;

  const DetailsCarState({
    this.groups = const [],
    this.status = FetchStatus.initial,
    this.error,
    this.params
  });

  @override
  List<Object?> get props => [groups, status, error, params];

  DetailsCarState copyWith({
    List<GroupModel>? groups,
    FetchStatus? status,
    IndexGroupParams? params,
    ErrorModel? error
  }) {
    return DetailsCarState(
        groups: groups ?? this.groups,
        status: status ?? this.status,
        params: params ?? this.params,
        error: error ?? this.error
    );
  }
}
