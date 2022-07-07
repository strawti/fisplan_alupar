import 'dart:io';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/requests/inspection_request_model.dart';
import '../../models/responses/inspection_model.dart';
import '../../repositories/inspections/inspections_repository.dart';

class InspectionsProvider {
  final InspectionsRepository _repository;
  InspectionsProvider(this._repository);

  Future<ProviderResponseModel<List<InspectionModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('InspectionsProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> sendPhoto(
    int inspectionId,
    String photoInBase64,
  ) async {
    try {
      final response = await _repository.sendPhoto(
        inspectionId,
        photoInBase64,
      );

      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('InspectionsProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> sendInspection(
    InspectionRequestModel request,
  ) async {
    try {
      final response = await _repository.sendInspection(request);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('InspectionsProvider.sendInspection() $e');
    }
  }
}
