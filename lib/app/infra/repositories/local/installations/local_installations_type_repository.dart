import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/responses/installation_type_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalInstallationsTypeRepository {
  final GetStorage _storage;
  LocalInstallationsTypeRepository(this._storage);

  Future<void> set(List<InstallationTypeModel> data) async {
    await _storage.write(
      apiInstallationTypes,
      data.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<InstallationTypeModel>> getAll() async {
    final data = await _storage.read(apiInstallationTypes);
    return List<InstallationTypeModel>.from(
      data?.map((e) => InstallationTypeModel.fromJson(e)) ?? [],
    );
  }

  Future<void> clear() async {
    await _storage.remove(apiInstallationTypes);
  }
}
