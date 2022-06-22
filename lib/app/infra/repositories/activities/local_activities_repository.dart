import 'package:get_storage/get_storage.dart';

import '../../api_endpoints.dart';
import '../../models/responses/activity_model.dart';

class LocalActivitiesRepository {
  final GetStorage _storage;
  LocalActivitiesRepository(this._storage);

  Future<void> set(List<ActivityModel> data) async {
    await _storage.write(
      'Activities_LastTimeUpdated',
      DateTime.now().millisecondsSinceEpoch,
    );

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

  Future<DateTime> getLastTimeUpdated() async {
    final data = await _storage.read('Activities_LastTimeUpdated');
    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
