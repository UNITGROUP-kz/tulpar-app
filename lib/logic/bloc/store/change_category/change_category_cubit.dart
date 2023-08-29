import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/data/params/profile/change_category_params.dart';

import '../../../../data/enums/fetch_status.dart';
import '../../../../data/models/error_model.dart';
import '../../../../data/repositories/store/auth_store_repository.dart';
import '../auth/auth_store_cubit.dart';

part 'change_category_state.dart';

class ChangeCategoryCubit extends Cubit<ChangeCategoryState> {
  ChangeCategoryCubit(this.authCubit) : super(const ChangeCategoryState());
  final AuthStoreCubit authCubit;


  change(ChangeCategoryParams params) {
    if(state.status == FetchStatus.loading) return;
    emit(ChangeCategoryState(status: FetchStatus.loading));
    AuthStoreRepository.updateCategory(params).then((value) {
      authCubit.set(value);
      emit(ChangeCategoryState(status: FetchStatus.success));
    }).catchError((error) {
      print(error);
      emit(ChangeCategoryState(status: FetchStatus.error, error: ErrorModel.parse(error)));
    });
  }
}
