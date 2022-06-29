import 'package:fisplan_alupar/app/infra/models/requests/inspection_request_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../api_endpoints.dart';
import '../../models/responses/inspection_model.dart';

class LocalInspectionsRepository {
  final GetStorage _storage;
  LocalInspectionsRepository(this._storage);

  Future<void> set(List<InspectionModel> data) async {
    await _storage.write(
      'Inspections_LastTimeUpdated',
      DateTime.now().millisecondsSinceEpoch,
    );
    await _storage.write(
      apiInspections,
      data.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<InspectionModel>> getAll() async {
    final data = await _storage.read(apiInspections);
    return List<InspectionModel>.from(
      data?.map(
            (e) => InspectionModel.fromJson(e),
          ) ??
          [],
    );
  }

  Future<void> clear() async {
    await _storage.remove(apiInspections);
  }

  Future<DateTime> getLastTimeUpdated() async {
    final data = await _storage.read('Inspections_LastTimeUpdated');
    return DateTime.fromMillisecondsSinceEpoch(data);
  }

  Future<void> setUnsynchronized(List<InspectionRequestModel> data) async {
    await _storage.write(
      'inspections_unsynchronized',
      DateTime.now().millisecondsSinceEpoch,
    );
    await _storage.write(
      apiInspections,
      data.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<InspectionRequestModel>> getAllUnsynchronized() async {
    final data = await _storage.read("inspections_unsynchronized");
    return List<InspectionRequestModel>.from(
      data?.map((e) {
            return InspectionRequestModel.fromJson(e);
          }) ??
          [],
    );
  }

  Future<void> clearUnsynchronized() async {
    await _storage.remove("inspections_unsynchronized");
  }
}
