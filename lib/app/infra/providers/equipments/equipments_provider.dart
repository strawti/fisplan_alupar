import 'dart:io';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/equipment_model.dart';
import '../../repositories/equipments/equipment_repository.dart';

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
