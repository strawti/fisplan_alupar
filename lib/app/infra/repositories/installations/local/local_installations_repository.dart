import 'package:get_storage/get_storage.dart';

import '../../../api_endpoints.dart';
import '../../../models/responses/installation_model.dart';

class LocalInstallationsRepository {
  final GetStorage _storage;
  LocalInstallationsRepository(this._storage);

  Future<void> setInstallations(List<InstallationModel> data) async {
    await _storage.write(
      'Installations_LastTimeUpdated',
      DateTime.now().millisecondsSinceEpoch,
    );
    await _storage.write(
      apiInstallations,
      data.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<InstallationModel>> getInstallations() async {
    final data = await _storage.read(apiInstallations);
    return List<InstallationModel>.from(
      data?.map((e) => InstallationModel.fromJson(e)) ?? [],
    );
  }

  Future<void> clearInstallations() async {
    await _storage.remove(apiInstallations);
  }

  Future<DateTime> getLastTimeUpdated() async {
    final data = await _storage.read('Installations_LastTimeUpdated');
    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
