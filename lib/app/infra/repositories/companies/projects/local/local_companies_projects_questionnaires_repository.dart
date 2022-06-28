import 'package:get_storage/get_storage.dart';

import '../../../../models/responses/questionnary_model.dart';

class LocalCompaniesProjectsQustionnairesRepository {
  final GetStorage _storage;
  LocalCompaniesProjectsQustionnairesRepository(this._storage);

  Future<void> set(List<QuestionnaryModel> data) async {
    await _storage.write(
      'Questionnaires_LastTimeUpdated',
      DateTime.now().millisecondsSinceEpoch,
    );

    await _storage.write(
      "projectsQuestionnaires",
      data.map((e) {
        return e.toJson();
      }).toList(),
    );
  }

  Future<List<QuestionnaryModel>> getAll() async {
    final data = await _storage.read("projectsQuestionnaires");
    return List<QuestionnaryModel>.from(
      data?.map((e) => QuestionnaryModel.fromJson(e)) ?? [],
    );
  }

  Future<void> clear() async => await _storage.remove("projectsQuestionnaires");

  Future<DateTime> getLastTimeUpdated() async {
    final data = await _storage.read('Questionnaires_LastTimeUpdated');
    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
