import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/arguments/new_inspection_page_arguments.dart';
import '../../shared/widgets/search_widget.dart';
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
              controller.routeArguments!.project.name,
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
                  if (control.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

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
                    )..insertAll(
                        0,
                        List.generate(
                          control.inspectionsUnsynchronized.length,
                          (index) {
                            final inspUnsy =
                                control.inspectionsUnsynchronized[index];
                            return ListTile(
                              title: Text(inspUnsy.name),
                              subtitle: const Text("Não foi sincronizado!"),
                              trailing: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              onTap: () {
                                Get.toNamed(
                                  NewInspectionPage.route,
                                  arguments: NewInspectionPageArguments(
                                    Get.find<InspectionsController>()
                                        .routeArguments!
                                        .project,
                                    inspectionRequest: inspUnsy,
                                  ),
                                );
                              },
                            );
                          },
                        ),
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
              controller.routeArguments!.project,
            ),
          );
        },
        label: const Text('Nova Inspeção'),
      ),
    );
  }
}
