import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/questionnaires_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../inspections/inspections_controller.dart';
import '../new_inspection/controllers/activities_controller.dart';
import '../new_inspection/controllers/companies_controller.dart';
import '../new_inspection/controllers/equipments_categories_controller.dart';
import '../new_inspection/controllers/equipments_controller.dart';
import '../new_inspection/controllers/installation_type_controller.dart';
import '../new_inspection/controllers/installations_controller.dart';
import '../new_inspection/controllers/towers_controller.dart';
import 'download_data_controller.dart';

class DownloadDataPage extends GetView<DownloadDataController> {
  const DownloadDataPage({Key? key}) : super(key: key);

  static const route = '/download-data';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isLoading()) {
          Get.dialog(
            const AlertDialog(
              title: Text('Aguarde o download dos dados'),
              content: Text(
                'Permaneça na tela para que o download dos dados seja concluído.',
              ),
            ),
          );
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
                Get.dialog(
                  const AlertDialog(
                    title: Text('Aguarde'),
                    content: Text('Aguarde o download dos dados'),
                  ),
                );
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
              DownloadItemWidget<CompaniesController>(
                control: Get.find<CompaniesController>(),
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
              const SizedBox(height: 60),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GetBuilder<DownloadDataController>(
          builder: (control) {
            return FloatingActionButton.extended(
              onPressed: () {
                if (control.isLoading() == false) {
                  Get.find<TowersController>().fetch(online: true);
                  Get.find<InstallationTypeController>().fetch(online: true);
                  Get.find<InstallationsController>().fetch(online: true);
                  Get.find<EquipmentsController>().fetch(online: true);
                  Get.find<EquipmentsCategoriesController>()
                      .fetch(online: true);
                  Get.find<InspectionsController>().fetch(online: true);
                  Get.find<CompaniesController>().fetch(online: true);
                  Get.find<ActivitiesController>().fetch(online: true);
                }
              },
              label: const Text('Sincronizar tudo'),
            );
          },
        ),
      ),
    );
  }
}

class DownloadItemWidget<T extends GetxController> extends StatelessWidget {
  final dynamic control;
  final String title;
  const DownloadItemWidget({
    Key? key,
    required this.control,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        return ListTile(
          isThreeLine: true,
          leading: control.isLoading ? const CircularProgressIndicator() : null,
          title: Text(title),
          subtitle: Text(
            "Última atualização: ${control.lastUpdate}",
          ),
          trailing: control.isLoading
              ? null
              : IconButton(
                  onPressed: () async {
                    await control.fetch(online: true);
                  },
                  icon: const Icon(Icons.sync),
                ),
        );
      },
    );
  }
}
