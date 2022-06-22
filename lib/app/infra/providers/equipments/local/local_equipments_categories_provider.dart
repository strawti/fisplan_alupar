import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../models/responses/equipment_category_model.dart';
import '../../../repositories/equipments/local/local_equipments_categories_repository.dart';

class LocalEquipmentsCategoriesProvider {
  final LocalEquipmentsCategoriesRepository _repository;
  LocalEquipmentsCategoriesProvider(this._repository);

  Future<ProviderResponseModel<List<EquipmentCategoryModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
          'LocalEquipmentsCategoriesProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> set(
    List<EquipmentCategoryModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalEquipmentsCategoriesProvider.set() $e',
      );
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalEquipmentsCategoriesProvider.clear() $e',
      );
    }
  }

  Future<ProviderResponseModel<DateTime?>> getLastTimeUpdated() async {
    try {
      final response = await _repository.getLastTimeUpdated();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalEquipmentsCategoriesProvider.getLastTimeUpdated() $e',
      );
    }
  }
}
