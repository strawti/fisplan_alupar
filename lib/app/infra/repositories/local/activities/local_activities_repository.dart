import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/responses/activity_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalActivitiesRepository {
  final GetStorage _storage;
  LocalActivitiesRepository(this._storage);

  Future<void> set(List<ActivityModel> data) async {
    await _storage.write(
      apiActivities,
      data.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<ActivityModel>> getAll() async {
    final data = await _storage.read(apiActivities);
    return List<ActivityModel>.from(
      data?.map((e) {
            return ActivityModel.fromJson(e);
          }) ??
          [],
    );
  }

  Future<void> clear() async {
    await _storage.remove(apiActivities);
  }
}
