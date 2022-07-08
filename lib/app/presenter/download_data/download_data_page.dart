import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/controllers/activities_controller.dart';
import '../../shared/controllers/companies_controller.dart';
import '../../shared/controllers/equipments_categories_controller.dart';
import '../../shared/controllers/equipments_controller.dart';
import '../../shared/controllers/installation_type_controller.dart';
import '../../shared/controllers/installations_controller.dart';
import '../../shared/controllers/questionnaires_controller.dart';
import '../../shared/controllers/steps_controller.dart';
import '../../shared/controllers/towers_controller.dart';
import '../../shared/utils/custom_dialog.dart';
import '../home/home_controller.dart';
import '../inspections/inspections_controller.dart';
import 'download_data_controller.dart';
import 'widgets/download_item_widget.dart';
import 'widgets/inspection_unsynchronized_widget.dart';

class DownloadDataPage extends GetView<DownloadDataController> {
  const DownloadDataPage({Key? key}) : super(key: key);

  static const route = '/download-data';

  void _showExitDialog() {
    CustomDialog().showDialog(
      title: 'Aguarde o download dos dados',
      middleText:
          'Permaneça na tela para que o download dos dados seja concluído.',
      textConfirm: 'Ok',
      textCancel: 'Cancelar e Sair',
      onConfirm: Get.back,
      onCancel: () {
        Get.back();
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isLoading()) {
          _showExitDialog();

          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Baixar dados'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (controller.isLoading()) {
                _showExitDialog();
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              DownloadItemWidget<TowersController>(
                control: Get.find<TowersController>(),
                title: 'Torres',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<InstallationTypeController>(
                control: Get.find<InstallationTypeController>(),
                title: 'Tipos de instalação',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<InstallationsController>(
                control: Get.find<InstallationsController>(),
                title: 'Instalações',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<EquipmentsController>(
                control: Get.find<EquipmentsController>(),
                title: 'Equipamentos',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<EquipmentsCategoriesController>(
                control: Get.find<EquipmentsCategoriesController>(),
                title: 'Categorias de Equipamentos',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<InspectionsController>(
                control: Get.find<InspectionsController>(),
                title: 'Inspeções',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<CompaniesTensionLevelController>(
                control: Get.find<CompaniesTensionLevelController>(),
                title: 'Empresas',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<ActivitiesController>(
                control: Get.find<ActivitiesController>(),
                title: 'Atividades',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<QuestionnairesController>(
                control: Get.find<QuestionnairesController>(),
                title: 'Questionários',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<StepsController>(
                control: Get.find<StepsController>(),
                title: 'Etapas',
              ),
              const SizedBox(height: 2),
              DownloadItemWidget<HomeController>(
                control: Get.find<HomeController>(),
                title: 'Projetos',
              ),
              const SizedBox(height: 20),
              GetBuilder<InspectionsController>(
                builder: (control) {
                  return Column(
                    children: control.inspectionsUnsynchronized.map(
                      (e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GetBuilder<InspectionsController>(
                            id: e.createdAt.toString(),
                            builder: (_) {
                              return InspectionUnsynchronizedWidget(
                                inspection: e,
                                control: control,
                              );
                            },
                          ),
                        );
                      },
                    ).toList(),
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GetBuilder<DownloadDataController>(
          builder: (control) {
            return FloatingActionButton.extended(
              onPressed: control.syncAll,
              label: const Text('Sincronizar tudo'),
            );
          },
        ),
      ),
    );
  }
}
