import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/activity_model.dart';
import '../../infra/providers/activities/activities_provider.dart';
import '../../infra/providers/activities/local_activities_provider.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

class ActivitiesController extends GetxController with LoaderManager {
  static ActivitiesController get to => Get.find();

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
    activitiesFiltered = _activities.toList();

    if (await AppConnectivity.instance.isConnected()) {
      if (_activities.isEmpty || online) {
        await _getAll();
      }
    }

    activitiesFiltered = _activities.toList();
    _getLastTimeUpdated();

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

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localActivitiesProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }
}
