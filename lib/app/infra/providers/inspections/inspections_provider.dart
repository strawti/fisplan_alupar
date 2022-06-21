import 'dart:io';

import 'package:fisplan_alupar/app/infra/models/inspection_model.dart';
import 'package:fisplan_alupar/app/infra/repositories/inspections/inspections_repository.dart';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';

class InspectionsProvider {
  final InspectionsRepository _repository;
  InspectionsProvider(this._repository);

  Future<ProviderResponseModel<List<InspectionModel>>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('InspectionsProvider.getAll() $e');
    }
  }
}
