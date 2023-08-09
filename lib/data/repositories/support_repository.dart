import 'package:garage/data/params/profile/support_params.dart';

import '../../core/services/api/api_service.dart';

class SupportRepository {
  static Future support(SupportParams params) => ApiService.I
      .post('/send-message', data: params.toData());
}