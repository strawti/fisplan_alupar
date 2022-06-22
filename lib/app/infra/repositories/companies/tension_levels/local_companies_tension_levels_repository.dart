import 'package:get_storage/get_storage.dart';

import '../../../models/responses/tension_level_model.dart';

class LocalCompaniesTensionLevelsRepository {
  final GetStorage _storage;
  LocalCompaniesTensionLevelsRepository(this._storage);

  Future<void> set(List<TensionLevelModel> data) async {
    await _storage.write(
      'CompaniesTensionLevels_LastTimeUpdated',
      DateTime.now().millisecondsSinceEpoch,
    );
    await _storage.write("tensionLevels", data.map((e) => e.toJson()).toList());
  }

  Future<List<TensionLevelModel>> getAll() async {
    final data = await _storage.read("tensionLevels");
    return List<TensionLevelModel>.from(
      data?.map((e) => TensionLevelModel.fromJson(e)) ?? [],
    );
  }

  Future<void> clear() async => await _storage.remove("tensionLevels");

  Future<DateTime> getLastTimeUpdated() async {
    final data = await _storage.read('CompaniesTensionLevels_LastTimeUpdated');
    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
