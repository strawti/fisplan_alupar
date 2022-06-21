import 'package:fisplan_alupar/app/presenter/inspections/widgets/inspection_widget.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/new_inspection_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './inspections_controller.dart';
import '../../shared/widgets/textform_widget.dart';

class InspectionsPage extends GetView<InspectionsController> {
  const InspectionsPage({Key? key}) : super(key: key);

  static const route = '/inspections';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspeções'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              controller.routeArguments.project.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<InspectionsController>(
              builder: (control) {
                return TextFormWidget(
                  controller: control.searhController,
                  hintText: 'Procurar',
                  textInputAction: TextInputAction.search,
                  prefixIcon: const Icon(Icons.search),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<InspectionsController>(
                builder: (control) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      control.inspectionsFiltered.length,
                      (index) {
                        return InspectionWidget(
                          inspection: control.inspectionsFiltered[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(NewInspectionPage.route);
        },
        label: const Text('Nova Inspeção'),
      ),
    );
  }
}
