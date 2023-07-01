import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/params/auth/auth_store_params.dart';

class AuthStoreRepository{
  Future login(LoginStoreParams params) => ApiService.I.post('/store/login', data: params.toData());
}