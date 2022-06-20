import 'package:fisplan_alupar/app/infra/models/equipment_model.dart';

import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../repositories/local/equipments/local_equipments_repository.dart';

class LocalEquipmentsProvider {
  final LocalEquipmentsRepository _repository;
  LocalEquipmentsProvider(this._repository);

  Future<ProviderResponseModel<List<EquipmentModel>?>> getAll() async {
    try {
      final response = await _repository.getEquipments();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalEquipmentsProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> setEquipments(
    List<EquipmentModel> data,
  ) async {
    try {
      await _repository.setEquipments(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalEquipmentsProvider.setEquipments() $e',
      );
    }
  }

  Future<ProviderResponseModel> clearEquipments() async {
    try {
      await _repository.clearEquipments();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalEquipmentsProvider.clearEquipments() $e',
      );
    }
  }
}