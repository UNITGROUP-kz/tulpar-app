part of 'part_picker_cubit.dart';

class PartPickerState extends Equatable {
  final List<PartModel> parts;
  final FetchStatus status;

  const PartPickerState({
    this.parts = const [],
    this.status = FetchStatus.initial
  });

  @override
  List<Object?> get props => [parts, status];

  PartPickerState copyWith({
    List<PartModel>? parts,
    FetchStatus? status,
  }) {
    return PartPickerState(
        parts: parts ?? this.parts,
        status: status ?? this.status,
    );
  }
}
