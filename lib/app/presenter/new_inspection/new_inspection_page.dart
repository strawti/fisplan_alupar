import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/installation_type_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/new_inspection_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './new_inspection_controller.dart';
import '../../infra/models/defaults/item_selection_model.dart';
import '../../routes/arguments/selection_page_arguments.dart';
import '../selection_page/selection_page.dart';

class NewInspectionPage extends GetView<NewInspectionController> {
  const NewInspectionPage({Key? key}) : super(key: key);

  static const String route = '/new-inspection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewInspectionPage'),
      ),
      body: const NewInspectionBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final data = Get.find<InstallationTypeController>().installationTypes;

          Get.toNamed(
            SelectionPage.route,
            arguments: SelectionPageArguments(
              title: 'Tipo de Instalação',
              items: data
                  .map((e) => ItemSelectionModel(
                        title: e.name,
                        item: e,
                      ))
                  .toList(),
            ),
          );
        },
        label: const Text('Atualizar dados'),
      ),
    );
  }
}
