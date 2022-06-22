import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/activity_model.dart';
import 'package:get/get.dart';

import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';

class ActivitiesRepository {
  final GetConnect _connect;
  ActivitiesRepository(this._connect);

  Future<ApiResponseModel<ActivityModel>> getAll() async {
    final response = await _connect.get(apiActivities);

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        'message': response.statusText,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(data: ActivityModel.fromMap(responseModel.data));
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter os dados',
      response: responseModel,
    );
  }
}
