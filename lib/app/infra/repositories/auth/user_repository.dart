import 'package:fisplan_alupar/app/infra/models/responses/user_response_model.dart';
import 'package:get/get.dart';

import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';

class UserRepository {
  UserRepository(this._connect);
  final GetConnect _connect;

  Future<ApiResponseModel<UserResponseModel?>> getUser() async {
    final response = await _connect.get(apiMe);

    final responseModel = DefaultResponseModel.fromMap({
      'data': response.body,
      'success': response.statusCode == 200,
      'error': {
        'message': response.statusText,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: UserResponseModel.fromMap(
          responseModel.data,
        ),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter usuário',
      response: responseModel,
    );
  }
}
