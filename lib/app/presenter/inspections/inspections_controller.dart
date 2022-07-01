import 'dart:developer';

import 'package:fisplan_alupar/app/infra/models/requests/inspection_request_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/inspection_model.dart';
import '../../infra/providers/inspections/inspections_provider.dart';
import '../../infra/providers/inspections/local_inspections_provider.dart';
import '../../routes/arguments/inspections_page_arguments.dart';
import '../../shared/utils/get_datetime.dart';
import '../../shared/utils/loader_manager.dart';

class InspectionsController extends GetxController with LoaderManager {
  final LocalInspectionsProvider _localInspectionsProvider;
  final InspectionsProvider _inspectionsProvider;

  InspectionsController(
    this._inspectionsProvider,
    this._localInspectionsProvider,
  ) {
    if (Get.arguments is InspectionsPageArguments) {
      routeArguments = Get.arguments;
    } else {
      log("Passe InspectionsPageArguments nos argumentos da rota");
    }
  }

  InspectionsPageArguments? routeArguments;

  @override
  void onReady() {
    super.onReady();

    fetch();

    searchController.addListener(() {
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

    searchController.dispose();
  }

  final searchController = TextEditingController();
  String get searchText => searchController.text.trim().toLowerCase();

  Future fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalInspections();

    if (await AppConnectivity.instance.isConnected()) {
      if (inspections.isEmpty || online) {
        await _getInspections();
      }
    }

    if (routeArguments != null) {
      inspections = inspections.where((e) {
        return e.projectId == routeArguments!.project.id;
      }).toList();
    }

    await _getInspectionsNotSynced();

    inspectionsFiltered = inspections.toList();
    inspectionsFiltered.sort((a, b) => a.progress.compareTo(b.progress));
    _getLastTimeUpdated();

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

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localInspectionsProvider.getLastTimeUpdated();
    if (response.isSuccess) {
      lastUpdate = getDateTime(response.data!);
    }
  }

  List<InspectionRequestModel> inspectionsUnsynchronized = [];
  Future _getInspectionsNotSynced() async {
    final response = await _localInspectionsProvider.getAllUnsynchronized();
    if (response.isSuccess) {
      inspectionsUnsynchronized = response.data ?? [];
    }
  }

  Future syncInspections({InspectionRequestModel? inspection}) async {
    List<InspectionRequestModel> data = [];

    if (inspection != null) {
      data.add(inspection);
    } else {
      data = inspectionsUnsynchronized.toList();
    }

    for (var inspection in data) {
      isLoading = true;
      update([inspection.createdAt.toString()]);

      final responseSendInspection = await _inspectionsProvider.sendInspection(
        inspection,
      );

      if (responseSendInspection.isSuccess) {
        inspectionsUnsynchronized.remove(inspection);
        inspectionsUnsynchronized.add(
          inspection.copyWith(
            id: responseSendInspection.data!,
            isSendInspection: true,
          ),
        );

        await sendPhotos(responseSendInspection.data, inspection);
      }

      isLoading = false;
      update([inspection.createdAt.toString()]);
    }
  }

  Future sendPhotos(int inspectionId, InspectionRequestModel inspection) async {
    final imagesUnsync = <PhotoModel>[];
    for (var photo in inspection.photos) {
      final responseSendPhoto = await _inspectionsProvider.sendPhoto(
        inspectionId,
        photo.path,
      );

      if (responseSendPhoto.isSuccess == false) {
        imagesUnsync.add(photo);
      }
    }

    if (imagesUnsync.isNotEmpty) {
      inspectionsUnsynchronized.remove(inspection);
      inspectionsUnsynchronized.add(
        inspection.copyWith(
          id: inspectionId,
          photos: imagesUnsync,
          isSendInspection: true,
        ),
      );
    } else {
      inspectionsUnsynchronized.remove(inspection);
      inspectionsUnsynchronized.add(
        inspection.copyWith(
          id: inspectionId,
          photos: imagesUnsync,
          isSendInspection: true,
          isSendPhotos: true,
        ),
      );
    }
  }
}
