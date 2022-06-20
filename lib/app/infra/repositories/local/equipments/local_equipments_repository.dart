import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/equipment_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalEquipmentsRepository {
  final GetStorage _storage;
  LocalEquipmentsRepository(this._storage);

  Future<void> setEquipments(List<EquipmentModel> data) async {
    await _storage.write(apiEquipments, data.map((e) => e.toJson()));
  }

  Future<List<EquipmentModel>> getEquipments() async {
    final data = await _storage.read(apiEquipments);
    return data.map((e) => EquipmentModel.fromJson(e)).toList();
  }

  Future<void> clearEquipments() async {
    await _storage.remove(apiEquipments);
  }
}