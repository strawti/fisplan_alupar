import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/arguments/new_inspection_page_arguments.dart';
import '../../new_inspection/new_inspection_page.dart';
import '../inspections_controller.dart';
import 'inspection_widget.dart';

class InspectionsWidget extends StatelessWidget {
  const InspectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  _buildInspectionUnsync(
                    control.inspectionsUnsynchronized,
                  ),
                ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildInspectionUnsync(
    inspectionsUnsynchronized,
  ) {
    return List.generate(
      inspectionsUnsynchronized.length,
      (index) {
        final inspUnsy = inspectionsUnsynchronized[index];
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
                Get.find<InspectionsController>().routeArguments!.project,
                inspectionRequest: inspUnsy,
              ),
            );
          },
        );
      },
    );
  }
}
