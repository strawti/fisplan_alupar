import 'package:get_storage/get_storage.dart';

import '../../api_endpoints.dart';
import '../../models/responses/tower_model.dart';

class LocalTowersRepository {
  final GetStorage _storage;
  LocalTowersRepository(this._storage);

  Future<void> set(List<TowerModel> data) async {
    await _storage.write(apiTowers, data.map((e) => e.toJson()).toList());
  }

  Future<List<TowerModel>> getAll() async {
    final data = await _storage.read(apiTowers);
    return List<TowerModel>.from(
      data?.map(
        (e) => TowerModel.fromJson(e),
      ) ?? [],
    );
  }

  Future<void> clear() async {
    await _storage.remove(apiTowers);
  }
}
