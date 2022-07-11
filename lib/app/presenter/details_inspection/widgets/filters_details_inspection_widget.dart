import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../new_inspection/widgets/new_inspection_card.dart';
import '../../new_inspection/widgets/tower_widget.dart';
import '../details_inspection_controller.dart';

class FiltersDetailsInspectionWidget extends StatelessWidget {
  const FiltersDetailsInspectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewInspectionCard(
      title: 'Filtros',
      child: Column(
        children: [
          const SizedBox(height: 20),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return ListTile(
                title: const Text('Nome'),
                subtitle: Text(
                  controller.name,
                  textScaleFactor: 1.1,
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return ListTile(
                title: const Text('Descrição'),
                subtitle: Text(
                  controller.description,
                  textScaleFactor: 1.1,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black12,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return ListTile(
                title: const Text('Tipo de Instalação'),
                subtitle: Text(
                  controller.selectedInstallationType?.name ?? '',
                  textScaleFactor: 1.1,
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showInstallation,
                child: ListTile(
                  title: const Text('Instalação'),
                  subtitle: Text(
                    controller.selectedInstallation?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showTower,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Torre'),
                      subtitle: Text(
                        controller.selectedTower?.name ?? '',
                        textScaleFactor: 1.1,
                      ),
                    ),
                    if (controller.selectedTower != null)
                      TowerWidget(
                        tower: controller.selectedTower!,
                      ),
                  ],
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showEquipmentCategory,
                child: ListTile(
                  title: const Text('Categoria do equipamento'),
                  subtitle: Text(
                    controller.selectedEquipmentsCategory?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showTensionLevel,
                child: ListTile(
                  title: const Text('Nível de tensão'),
                  subtitle: Text(
                    controller.selectedTensionLevel?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showEquipment,
                child: ListTile(
                  title: const Text('Equipamento'),
                  subtitle: Text(
                    controller.selectedEquipment?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showStep,
                child: ListTile(
                  title: const Text('Etapa'),
                  subtitle: Text(
                    controller.selectedStep?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                ),
              );
            },
          ),
          GetBuilder<DetailsInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showActivity,
                child: ListTile(
                  title: const Text('Atividade'),
                  subtitle: Text(
                    controller.selectedActivity?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
