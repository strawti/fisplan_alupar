import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/tower_model.dart';
import '../../repositories/towers/local_towers_repository.dart';

class LocalTowersProvider {
  final LocalTowersRepository _repository;
  LocalTowersProvider(this._repository);

  Future<ProviderResponseModel<List<TowerModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalTowersRepository.getAll() $e');
    }
  }

  Future<ProviderResponseModel> set(
    List<TowerModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel('LocalTowersRepository.set() $e');
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel('LocalTowersRepository.clear() $e');
    }
  }

  Future<ProviderResponseModel<DateTime>> getLastTimeUpdated() async {
    try {
      final response = await _repository.getLastTimeUpdated();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalTowersRepository.getLastTimeUpdated() $e',
      );
    }
  }
}
