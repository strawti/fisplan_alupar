import 'package:fisplan_alupar/app/routes/arguments/new_inspection_page_arguments.dart';
import 'package:fisplan_alupar/app/shared/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../new_inspection/new_inspection_page.dart';
import 'inspections_controller.dart';
import 'widgets/inspection_widget.dart';

class InspectionsPage extends GetView<InspectionsController> {
  const InspectionsPage({Key? key}) : super(key: key);

  static const route = '/inspections';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Inspeções')),
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
          SearchWidget<InspectionsController>(
            controller: controller.searchController,
          ),
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
          Get.toNamed(
            NewInspectionPage.route,
            arguments: NewInspectionPageArguments(
              controller.routeArguments.project,
            ),
          );
        },
        label: const Text('Nova Inspeção'),
      ),
    );
  }
}
