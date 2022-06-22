import 'package:fisplan_alupar/app/infra/models/responses/project_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalCompaniesProjectsRepository {
  final GetStorage _storage;
  LocalCompaniesProjectsRepository(this._storage);

  Future<void> set(List<ProjectModel> data) async {
    await _storage.write("projects", data.map((e) => e.toJson()).toList());
  }

  Future<List<ProjectModel>> getAll() async {
    final data = await _storage.read("projects");
    return List<ProjectModel>.from(
      data?.map((e) => ProjectModel.fromJson(e)) ?? [],
    );
  }

  Future<void> clear() async => await _storage.remove("projects");
}
