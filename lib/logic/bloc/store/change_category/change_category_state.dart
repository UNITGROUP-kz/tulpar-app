part of 'change_category_cubit.dart';

class ChangeCategoryState extends Equatable {
  final FetchStatus status;
  final ErrorModel? error;

  const ChangeCategoryState({
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [status, error];
}
