import 'package:fisplan_alupar/app/infra/models/responses/step_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalCompaniesProjectsStepsRepository {
  final GetStorage _storage;
  LocalCompaniesProjectsStepsRepository(this._storage);

  Future<void> set(List<StepModel> data) async {
    await _storage.write(
      'Steps_LastTimeUpdated',
      DateTime.now().millisecondsSinceEpoch,
    );
    await _storage.write("steps", data.map((e) => e.toJson()).toList());
  }

  Future<List<StepModel>> getAll() async {
    final data = await _storage.read("steps");
    return List<StepModel>.from(
      data?.map((e) => StepModel.fromJson(e)) ?? [],
    );
  }

  Future<void> clear() async => await _storage.remove("steps");

  Future<DateTime> getLastTimeUpdated() async {
    final data = await _storage.read('Steps_LastTimeUpdated');
    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
