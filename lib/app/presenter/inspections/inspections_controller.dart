import 'package:fisplan_alupar/app/infra/models/inspection_model.dart';
import 'package:fisplan_alupar/app/infra/providers/local/inspections/local_inspections_provider.dart';
import 'package:fisplan_alupar/app/routes/arguments/inspections_page_arguments.dart';
import 'package:fisplan_alupar/app/shared/utils/loader_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/providers/inspections/inspections_provider.dart';

class InspectionsController extends GetxController with LoaderManager {
  final LocalInspectionsProvider _localInspectionsProvider;
  final InspectionsProvider _inspectionsProvider;

  InspectionsController(
    this._inspectionsProvider,
    this._localInspectionsProvider,
  ) {
    assert(
      Get.arguments is InspectionsPageArguments,
      "Passe InspectionsPageArguments nos argumentos da rota",
    );

    routeArguments = Get.arguments;
  }

  late InspectionsPageArguments routeArguments;

  @override
  void onReady() {
    super.onReady();

    fetch();

    searhController.addListener(() {
      inspectionsFiltered.clear();

      for (var project in inspections) {
        if (project.name.toLowerCase().contains(searchText)) {
          inspectionsFiltered.add(project);
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

    await _getLocalInspections();

    if (await AppConnectivity.instance.isConnected()) {
      if (inspections.isEmpty) {
        await _getInspections();
      }
    }

    inspections = inspections.where((e) {
      return e.projectId == routeArguments.project.id;
    }).toList();

    inspectionsFiltered = inspections.toList();
    inspectionsFiltered.sort((a, b) => a.progress.compareTo(b.progress));

    setIsLoading(false);
  }

  List<InspectionModel> inspections = [];
  List<InspectionModel> inspectionsFiltered = [];

  Future _getLocalInspections() async {
    final response = await _localInspectionsProvider.getAll();
    if (response.isSuccess) {
      inspections = response.data ?? [];
    }
  }

  Future _getInspections() async {
    final response = await _inspectionsProvider.getAll();
    if (response.isSuccess) {
      inspections = response.data ?? [];
      await _localInspectionsProvider.set(inspections);
    }
  }
}
