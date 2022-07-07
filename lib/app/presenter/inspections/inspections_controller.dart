import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/requests/inspection_request_model.dart';
import '../../infra/models/responses/inspection_model.dart';
import '../../infra/models/responses/photo_model.dart';
import '../../infra/providers/inspections/inspections_provider.dart';
import '../../infra/providers/inspections/local_inspections_provider.dart';
import '../../routes/arguments/inspections_page_arguments.dart';
import '../../shared/utils/custom_dialog.dart';
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

    // Caso queira remover as inspeções
    // await _setLocalInspections();

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
    //inspectionsFiltered.sort((a, b) => b.name.compareTo(a.name));
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
      lastUpdate = formatDateTimeForString(response.data!);
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
      update();

      if (inspection.isSendInspection == false) {
        final responseSendInspection =
            await _inspectionsProvider.sendInspection(
          inspection,
        );

        if (responseSendInspection.isSuccess) {
          inspectionsUnsynchronized.remove(inspection);
          inspection = inspection.copyWith(
            id: responseSendInspection.data!,
            isSendInspection: true,
          );

          inspectionsUnsynchronized.add(inspection);
          await _setLocalInspections();

          if (inspection.isSendPhotos == false) {
            inspection = await sendPhotos(inspection);
          }

          // if (inspection.isSendAudios == false) {
          //   inspection = await sendAudios(inspection);
          // }
        }
      } else {
        if (inspection.isSendPhotos == false) {
          inspection = await sendPhotos(inspection);
        }

        // if (inspection.isSendAudios == false) {
        //   inspection = await sendAudios(inspection);
        // }
      }

      if (inspection.isSendInspection) {
        if (inspection.isSendPhotos) {
          inspectionsUnsynchronized.removeWhere((e) {
            return e.createdAt == inspection.createdAt;
          });
          // Confirm upgrade data
          inspectionsUnsynchronized.remove(inspection);

          await _setLocalInspections();
        }
      }

      isLoading = false;

      update();
    }

    await _getInspectionsNotSynced();

    if (inspectionsUnsynchronized.isEmpty) {
      await CustomDialog().show(
        textConfirm: 'Sim',
        textCancel: 'Não',
        title: 'Tudo certo!',
        middleText: 'Deseja as inspenções?',
        onConfirm: () {
          Get.back();
          fetch(online: true);
        },
        onCancel: Get.back,
      );
    }
  }

  Future<InspectionRequestModel> sendPhotos(
    InspectionRequestModel inspection,
  ) async {
    final imagesUnsync = <PhotoModel>[];
    for (var photo in inspection.photos) {
      final responseSendPhoto = await _inspectionsProvider.sendPhoto(
        inspection.id!,
        photo.path,
      );

      if (responseSendPhoto.isSuccess == false) {
        imagesUnsync.add(photo);
      }
    }

    inspectionsUnsynchronized.remove(inspection);
    if (imagesUnsync.isNotEmpty) {
      inspection = inspection.copyWith(
        id: inspection.id,
        photos: imagesUnsync,
        isSendPhotos: false,
      );
      inspectionsUnsynchronized.add(inspection);
    } else {
      inspection = inspection.copyWith(
        id: inspection.id,
        photos: imagesUnsync,
        isSendPhotos: true,
      );
      inspectionsUnsynchronized.add(inspection);
    }

    await _setLocalInspections();

    return inspection;
  }

  // Future<InspectionRequestModel> sendAudios(
  //   InspectionRequestModel inspection,
  // ) async {
  //   inspectionsUnsynchronized.remove(inspection);

  //   //final response = await _inspectionsProvider.sendPhoto(inspectionId, photoInBase64)

  //   inspection = inspection.copyWith(
  //     id: inspection.id,
  //     audios: [],
  //     isSendAudios: true,
  //   );
  //   inspectionsUnsynchronized.add(inspection);

  //   await _setLocalInspections();
  //   return inspection;
  // }

  Future _setLocalInspections() async {
    await _localInspectionsProvider.setUnsynchronized(
      inspectionsUnsynchronized,
    );
  }
}
