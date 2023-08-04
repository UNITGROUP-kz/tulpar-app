part of 'create_offer_cubit.dart';

class CreateOfferState extends Equatable {
  final FetchStatus status;
  final ErrorModel? error;

  const CreateOfferState({
    this.status = FetchStatus.initial,
    this.error
  });

  @override
  List<Object?> get props => [status, error];
}
