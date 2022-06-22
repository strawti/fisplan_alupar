import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/responses/equipment_category_model.dart';
import 'package:get/get.dart';

import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';

class EquipmentCategoryRepository {
  final GetConnect _connect;
  EquipmentCategoryRepository(this._connect);

  Future<ApiResponseModel<List<EquipmentCategoryModel>?>> getAll() async {
    final response = await _connect.get(apiEquipmentCategories);

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        'message': response.statusText,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: List<EquipmentCategoryModel>.from(
          responseModel.data.map((e) => EquipmentCategoryModel.fromMap(e)),
        ),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }
}
