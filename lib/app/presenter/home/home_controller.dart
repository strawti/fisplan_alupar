import 'package:fisplan_alupar/app/core/app_connectivity.dart';
import 'package:fisplan_alupar/app/infra/models/project_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/user_response_model.dart';
import 'package:fisplan_alupar/app/infra/providers/auth/user_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/companies/projects/local_companies_projects_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/local_user_provider.dart';
import 'package:fisplan_alupar/app/shared/utils/loader_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/providers/companies/projects/companies_projects_provider.dart';

class HomeController extends GetxController with LoaderManager {
  final CompaniesProjectsProvider _companiesProjectsProvider;
  final LocalCompaniesProjectsProvider _localCompaniesProjectsProvider;

  final LocalUserProvider _localUserProvider;
  final UserProvider _userProvider;

  HomeController(
    this._localUserProvider,
    this._userProvider,
    this._companiesProjectsProvider,
    this._localCompaniesProjectsProvider,
  );

  @override
  void onReady() {
    super.onReady();

    fetch();

    searhController.addListener(() {
      projectsFiltered.clear();

      for (var project in projectsFiltered) {
        if (project.name.toLowerCase().contains(searchText)) {
          projectsFiltered.add(project);
        }
      }

      update();
    });
  }

  @override
  void onClose() {
    super.onClose();

    searhController.dispose();
  }

  final searhController = TextEditingController();
  String get searchText => searhController.text.trim().toLowerCase();

  Future fetch() async {
    setIsLoading(true);

    await _getLocalUser();
    await _getLocalProjects();

    if (await AppConnectivity.instance.isConnected()) {
      if (user == null) {
        await _getUser();
      }

      if (projects.isEmpty) {
        await _getProjects();
      }
    }

    projectsFiltered = projects.toList();

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
}
