import 'package:get_storage/get_storage.dart';

import '../../../api_endpoints.dart';
import '../../../models/responses/equipment_model.dart';

class LocalEquipmentsRepository {
  final GetStorage _storage;
  LocalEquipmentsRepository(this._storage);

  Future<void> setEquipments(List<EquipmentModel> data) async {
    await _storage.write(
      apiEquipments,
      data.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<EquipmentModel>> getEquipments() async {
    final data = await _storage.read(apiEquipments);
    return data.map((e) => EquipmentModel.fromJson(e)).toList();
  }

  Future<void> clearEquipments() async {
    await _storage.remove(apiEquipments);
  }
}
