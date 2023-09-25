part of 'group_picker_cubit.dart';

class GroupPickerState extends Equatable {
  final List<GroupModel> groups;
  final FetchStatus status;

  const GroupPickerState({
    this.groups = const [],
    this.status = FetchStatus.initial
  });

  @override
  List<Object?> get props => [groups, status];

  GroupPickerState copyWith({
    List<GroupModel>? groups,
    FetchStatus? status,
  }) {
    return GroupPickerState(
        groups: groups ?? this.groups,
        status: status ?? this.status,
    );
  }
}
