import '../../../api_endpoints.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/responses/installation_model.dart';

class LocalInstallationsRepository {
  final GetStorage _storage;
  LocalInstallationsRepository(this._storage);

  Future<void> setInstallations(List<InstallationModel> data) async {
    await _storage.write(apiInstallations, data.map((e) => e.toJson()));
  }

  Future<List<InstallationModel>> getInstallations() async {
    final data = await _storage.read(apiInstallations);
    return data.map((e) => InstallationModel.fromJson(e)).toList();
  }

  Future<void> clearInstallations() async {
    await _storage.remove(apiInstallations);
  }
}
