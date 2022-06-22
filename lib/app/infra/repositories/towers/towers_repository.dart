import 'package:get/get.dart';

import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/responses/tower_model.dart';

class TowersRepository {
  final GetConnect _connect;
  TowersRepository(this._connect);

  Future<ApiResponseModel<List<TowerModel>>> getAllByCompanyId() async {
    final response = await _connect.get(apiTowers);

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        'message': response.statusText,
      },
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: List<TowerModel>.from(
          responseModel.data.map(
            (e) => TowerModel.fromMap(e),
          ),
        ),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }
}
