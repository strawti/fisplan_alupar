import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/installation_type_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalInstallationsTypeRepository {
  final GetStorage _storage;
  LocalInstallationsTypeRepository(this._storage);

  Future<void> setInstallations(List<InstallationTypeModel> data) async {
    await _storage.write(apiInstallationTypes, data.map((e) => e.toJson()));
  }

  Future<List<InstallationTypeModel>> getInstallations() async {
    final data = await _storage.read(apiInstallationTypes);
    return data.map((e) => InstallationTypeModel.fromJson(e)).toList();
  }

  Future<void> clearInstallations() async {
    await _storage.remove(apiInstallationTypes);
  }
}