import 'dart:convert';

import 'package:get/get.dart';

import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/requests/inspection_request_model.dart';
import '../../models/responses/inspection_model.dart';

class InspectionsRepository {
  final GetConnect _connect;
  InspectionsRepository(this._connect);

  Future<ApiResponseModel<List<InspectionModel>>> getAll() async {
    final response = await _connect.get(apiInspections);

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        "message": response.body,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: List<InspectionModel>.from(
          responseModel.data.map(
            (e) => InspectionModel.fromMap(e),
          ),
        ),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }

  Future<ApiResponseModel> sendPhoto(
    int inspectionId,
    String photoInBase64,
  ) async {
    final response = await _connect.post(
      "$apiInspections/$inspectionId/photos",
      json.encode({'photo': photoInBase64}),
    );

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        "message": response.body,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(data: responseModel.data);
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }

  Future<ApiResponseModel<int?>> sendInspection(
    InspectionRequestModel inspection,
  ) async {
    final response = await _connect.post(
      apiInspectionsSyncSingle,
      json.encode({"inspection": inspection.toMap()}),
    );

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        "message": response.body,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(data: responseModel.data["id"]);
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível enviar dados',
      response: responseModel,
    );
  }
}
