import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/tower_model.dart';
import 'package:get/get.dart';

import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';

class TowersRepository {
  final GetConnect _connect;
  TowersRepository(this._connect);

  Future<ApiResponseModel<List<TowerModel>>> getAllByCompanyId(
    int userCompanyId,
  ) async {
    final response = await _connect.get(apiTowers);

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
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
