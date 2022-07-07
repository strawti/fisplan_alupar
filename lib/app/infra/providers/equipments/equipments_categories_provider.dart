import 'dart:io';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/equipment_category_model.dart';
import '../../repositories/equipments/equipment_category_repository.dart';

class EquipmentsCategoriesProvider {
  final EquipmentCategoryRepository _repository;
  EquipmentsCategoriesProvider(this._repository);

  Future<ProviderResponseModel<List<EquipmentCategoryModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('EquipmentsCategoriesProvider.getAll() $e');
    }
  }
}
