import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_validators.dart';
import '../../../shared/widgets/textform_widget.dart';
import '../new_inspection_controller.dart';
import 'new_inspection_card.dart';
import 'tower_widget.dart';

class FiltersWidget extends StatelessWidget {
  const FiltersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewInspectionCard(
      title: 'Filtros',
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormWidget(
            controller: NewInspectionController.to.nameController,
            labelText: 'Nome',
            hintText: 'Nome da inspeção',
            validator: simpleValidate,
          ),
          const SizedBox(height: 20),
          TextFormWidget(
            controller: NewInspectionController.to.descriptionController,
            labelText: 'Descrição',
            hintText: 'Informe a descrição da inspeção',
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.black12, thickness: 1),
          const SizedBox(height: 10),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return ListTile(
                title: const Text('Tipo de Instalação'),
                trailing: const Icon(Icons.arrow_drop_down),
                subtitle: Text(
                  controller.selectedInstallationType?.name ?? '',
                  textScaleFactor: 1.1,
                ),
                onTap: controller.getInstallationType,
              );
            },
          ),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showInstallation,
                child: ListTile(
                  title: const Text('Instalação'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  subtitle: Text(
                    controller.selectedInstallation?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                  onTap: controller.getInstallation,
                ),
              );
            },
          ),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showTower,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Torres'),
                      trailing: const Icon(Icons.arrow_drop_down),
                      subtitle: Text(
                        controller.nameSelectedTowers,
                        textScaleFactor: 1.1,
                      ),
                      onTap: controller.getTowers,
                    ),
                    if (controller.selectedTowers != null)
                      ...List.generate(
                        controller.selectedTowers!.length,
                        (index) {
                          return TowerWidget(
                            tower: controller.selectedTowers![index],
                          );
                        },
                      )
                  ],
                ),
              );
            },
          ),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showEquipmentCategory,
                child: ListTile(
                  title: const Text('Categoria do equipamento'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  subtitle: Text(
                    controller.selectedEquipmentsCategory?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                  onTap: controller.getEquipmentsCategory,
                ),
              );
            },
          ),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showTensionLevel,
                child: ListTile(
                  title: const Text('Nível de tensão'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  subtitle: Text(
                    controller.selectedTensionLevel?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                  onTap: controller.getTensionLevel,
                ),
              );
            },
          ),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showEquipment,
                child: ListTile(
                  title: const Text('Equipamento'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  subtitle: Text(
                    controller.selectedEquipment?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                  onTap: controller.getEquipments,
                ),
              );
            },
          ),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showStep,
                child: ListTile(
                  title: const Text('Etapa'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  subtitle: Text(
                    controller.selectedStep?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                  onTap: controller.getSteps,
                ),
              );
            },
          ),
          GetBuilder<NewInspectionController>(
            builder: (controller) {
              return Visibility(
                visible: controller.showActivity,
                child: ListTile(
                  title: const Text('Atividade'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  subtitle: Text(
                    controller.selectedActivity?.name ?? '',
                    textScaleFactor: 1.1,
                  ),
                  onTap: controller.getActivities,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
