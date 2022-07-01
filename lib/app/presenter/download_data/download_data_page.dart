import 'package:fisplan_alupar/app/infra/models/requests/inspection_request_model.dart';
import 'package:fisplan_alupar/app/presenter/home/home_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/questionnaires_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/steps_controller.dart';
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
            AlertDialog(
              title: const Text('Aguarde o download dos dados'),
              content: const Text(
                'Permaneça na tela para que o download dos dados seja concluído.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: const Text(
                    'Sair sem concluir',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: Get.back,
                  child: const Text('Ok'),
                ),
              ],
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
                  AlertDialog(
                    title: const Text('Aguarde'),
                    content: const Text('Aguarde o download dos dados'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: const Text(
                          'Sair sem concluir',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: Get.back,
                        child: const Text('Ok'),
                      ),
                    ],
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
                  Get.find<HomeController>().fetch(online: true);
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

class InspectionUnsynchronizedWidget extends StatelessWidget {
  final InspectionRequestModel inspection;
  final InspectionsController control;
  const InspectionUnsynchronizedWidget({
    Key? key,
    required this.inspection,
    required this.control,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Inspeção ${inspection.name} não foi sincronizada",
            ),
          ),
          if (control.isLoading == false)
            IconButton(
              onPressed: () async {
                await control.syncInspections(
                  inspection: inspection,
                );
              },
              icon: const Icon(Icons.sync),
            ),
        ],
      ),
      subtitle: Column(
        children: [
          ListTile(
            title: const Text('Inspeção'),
            trailing: inspection.isSendInspection
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
          ),
          ListTile(
            title: const Text('Imagens'),
            trailing: inspection.isSendPhotos
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
          ),
          ListTile(
            title: const Text('Audios'),
            trailing: inspection.isSendAudios
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
          ),
          ListTile(
            title: const Text('Questionários'),
            trailing: inspection.isSendAnswers
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
          ),
        ],
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
