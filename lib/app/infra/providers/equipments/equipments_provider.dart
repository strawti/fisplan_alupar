import 'dart:io';

import 'package:fisplan_alupar/app/infra/models/responses/equipment_model.dart';
import 'package:fisplan_alupar/app/infra/repositories/equipments/equipment_repository.dart';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';

class EquipmentsProvider {
  final EquipmentRepository _repository;
  EquipmentsProvider(this._repository);

  Future<ProviderResponseModel<List<EquipmentModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('EquipmentsProvider.getAll() $e');
    }
  }
}
