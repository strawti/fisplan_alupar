import 'package:fisplan_alupar/app/shared/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_inspection_controller.dart';
import 'widgets/new_inspection_body.dart';

class NewInspectionPage extends StatelessWidget {
  const NewInspectionPage({Key? key}) : super(key: key);

  static const String route = '/new-inspection';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await CustomDialog().showDialog(
          title: 'Tem certeza?',
          middleText: 'Se você sair todos os dados serão perdidos.',
          onConfirm: () => Get.back(result: true),
          textConfirm: "Sim",
          textCancel: "Ficar",
        );

        return result == true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: NewInspectionController.to.arguments.inspectionRequest != null
              ? NewInspectionController.to.arguments.isItDuplication
                  ? const Text("Duplicação de Inspeção")
                  : const Text("Edição de Inspeção")
              : const Text("Nova Inspeção"),
        ),
        body: const NewInspectionBody(),
      ),
    );
  }
}
