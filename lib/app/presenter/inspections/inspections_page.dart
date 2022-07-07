import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/arguments/new_inspection_page_arguments.dart';
import '../new_inspection/new_inspection_page.dart';
import 'inspections_controller.dart';
import 'widgets/body_inspection_page.dart';

class InspectionsPage extends StatelessWidget {
  const InspectionsPage({Key? key}) : super(key: key);

  static const route = '/inspections';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Inspeções')),
      body: const BodyInspectionPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(
            NewInspectionPage.route,
            arguments: NewInspectionPageArguments(
              Get.find<InspectionsController>().routeArguments!.project,
            ),
          );
        },
        label: const Text('Nova Inspeção'),
      ),
    );
  }
}
