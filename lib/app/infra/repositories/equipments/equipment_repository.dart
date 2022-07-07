import 'package:get/get.dart';

import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/responses/equipment_model.dart';

class EquipmentRepository {
  final GetConnect _connect;
  EquipmentRepository(this._connect);

  Future<ApiResponseModel<List<EquipmentModel>?>> getAll() async {
    final response = await _connect.get(apiEquipments);

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
        data: List<EquipmentModel>.from(
          responseModel.data.map((e) => EquipmentModel.fromMap(e)),
        ),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }
}
