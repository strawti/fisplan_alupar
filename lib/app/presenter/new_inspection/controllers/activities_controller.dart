import 'package:fisplan_alupar/app/infra/models/responses/activity_model.dart';
import 'package:fisplan_alupar/app/infra/providers/activities/activities_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/activities/local_activities_provider.dart';
import 'package:fisplan_alupar/app/shared/utils/loader_manager.dart';
import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../shared/utils/custom_snackbar.dart';

class ActivitiesController extends GetxController with LoaderManager {
  final ActivitiesProvider _activitiesProvider;
  final LocalActivitiesProvider _localActivitiesProvider;

  ActivitiesController(
    this._activitiesProvider,
    this._localActivitiesProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<ActivityModel> _activities = [];
  List<ActivityModel> activitiesFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalAll();
    if (await AppConnectivity.instance.isConnected()) {
      if (_activities.isEmpty || online) {
        await _getAll();
      }
    }

    activitiesFiltered = _activities.toList();

    setIsLoading(false);
  }

  Future _getAll() async {
    final response = await _activitiesProvider.getAll();

    if (response.isSuccess) {
      _activities = response.data ?? [];
      _setLocal(_activities);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalAll() async {
    final response = await _localActivitiesProvider.getAll();

    if (response.isSuccess) {
      _activities = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<ActivityModel> data) async {
    final response = await _localActivitiesProvider.set(
      data,
    );

    if (response.isSuccess) {
      _activities = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  void filterByStep(int stepId) {
    activitiesFiltered = _activities.where((activity) {
      return activity.stepId == stepId;
    }).toList();

    update();
  }
}
