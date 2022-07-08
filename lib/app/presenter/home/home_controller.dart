import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/project_model.dart';
import '../../infra/models/responses/user_response_model.dart';
import '../../infra/providers/companies/projects/companies_projects_provider.dart';
import '../../infra/providers/companies/projects/local/local_companies_projects_provider.dart';
import '../../infra/providers/inspections/local_inspections_provider.dart';
import '../../infra/providers/user/local_user_provider.dart';
import '../../infra/providers/user/user_provider.dart';
import '../../shared/utils/custom_dialog.dart';
import '../../shared/utils/custom_snackbar.dart';
import '../../shared/utils/get_datetime.dart';
import '../../shared/utils/loader_manager.dart';
import '../auth/login/login_page.dart';
import '../download_data/download_data_page.dart';

class HomeController extends GetxController with LoaderManager {
  static HomeController get to => Get.find();

  final CompaniesProjectsProvider _companiesProjectsProvider;
  final LocalCompaniesProjectsProvider _localCompaniesProjectsProvider;
  final LocalInspectionsProvider _localInspectionsProvider;

  final LocalUserProvider _localUserProvider;
  final UserProvider _userProvider;

  HomeController(
    this._localUserProvider,
    this._userProvider,
    this._companiesProjectsProvider,
    this._localCompaniesProjectsProvider,
    this._localInspectionsProvider,
  );

  @override
  void onReady() {
    super.onReady();

    fetch();

    searchController.addListener(() {
      projectsFiltered.clear();

      for (var project in projects) {
        if (project.name.toLowerCase().contains(searchText)) {
          projectsFiltered.add(project);
        }
      }

      if (projectsFiltered.isEmpty && searchText.isEmpty) {
        projectsFiltered.addAll(projects);
      }

      update();
    });
  }

  @override
  void onClose() {
    super.onClose();

    searchController.dispose();
  }

  final searchController = TextEditingController();
  String get searchText => searchController.text.trim().toLowerCase();

  Future fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalUser();
    await _getLocalProjects();

    projectsFiltered = projects.toList();

    if (await AppConnectivity.instance.isConnected()) {
      if (user == null || online) {
        await _getUser();
      }

      if (projects.isEmpty || online) {
        await _getProjects();
      }
    }

    projectsFiltered = projects.toList();
    projectsFiltered.sort((a, b) => a.progress.compareTo(b.progress));

    if (GetStorage().read('isTheFirstTime')) {
      CustomDialog().showDialog(
        textConfirm: 'Sim',
        textCancel: 'Não',
        title: 'Bem-vindo(a)!',
        middleText: 'Precisamos baixar alguns dados para que o aplicativo'
            ' funcione corretamente, vamos fazer isso agora ?',
        onConfirm: () {
          Get.back();
          Get.toNamed(DownloadDataPage.route);
        },
        onCancel: Get.back,
      );
      GetStorage().write('isTheFirstTime', false);
    }

    getInspectionsUnsynch();
    _getLastTimeUpdated();

    setIsLoading(false);
  }

  UserResponseModel? user;
  Future _getLocalUser() async {
    final response = await _localUserProvider.getUser();
    if (response.isSuccess) {
      user = response.data;
    }
  }

  Future _getUser() async {
    final response = await _userProvider.getUser();
    if (response.isSuccess) {
      user = response.data;

      await _localUserProvider.setUser(user!);
    }
  }

  List<ProjectModel> projects = [];
  List<ProjectModel> projectsFiltered = [];

  Future _getProjects() async {
    final response = await _companiesProjectsProvider.getAll(
      user!.companyId,
    );

    if (response.isSuccess) {
      projects = response.data ?? [];
      await _localCompaniesProjectsProvider.set(projects);
    }
  }

  Future _getLocalProjects() async {
    final response = await _localCompaniesProjectsProvider.getAll();

    if (response.isSuccess) {
      projects = response.data ?? [];
    }
  }

  Future disconnectUser() async {
    setIsLoading(true);

    final response = await _userProvider.logout();

    if (response.isSuccess) {
      await Get.find<GetStorage>().erase();
      Get.offAllNamed(LoginPage.route);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }

    setIsLoading(false);
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localCompaniesProjectsProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }

  bool hasInspectionsUnsynch = false;
  Future getInspectionsUnsynch() async {
    final response = await _localInspectionsProvider.getAllUnsynchronized();
    if (response.isSuccess) {
      hasInspectionsUnsynch = response.data?.isNotEmpty ?? false;
    }
    update();
  }
}
