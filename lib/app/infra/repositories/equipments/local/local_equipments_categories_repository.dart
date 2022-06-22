import '../../../api_endpoints.dart';
import '../../../models/responses/equipment_category_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalEquipmentsCategoriesRepository {
  final GetStorage _storage;
  LocalEquipmentsCategoriesRepository(this._storage);

  Future<void> set(List<EquipmentCategoryModel> data) async {
    await _storage.write(apiEquipmentCategories, data.map((e) => e.toJson()));
  }

  Future<List<EquipmentCategoryModel>> getAll() async {
    final data = await _storage.read(apiEquipmentCategories);
    return List<EquipmentCategoryModel>.from(
      data?.map((e) => EquipmentCategoryModel.fromJson(e)) ?? [],
    );
  }

  Future<void> clear() async => await _storage.remove(apiEquipmentCategories);
}
