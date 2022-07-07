import '../../../infra/models/requests/inspection_request_model.dart';
import '../../new_inspection/new_inspection_page.dart';
import '../../../routes/arguments/new_inspection_page_arguments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/models/responses/inspection_model.dart';
import '../../../routes/arguments/datails_inspection_page_arguments.dart';
import '../../details_inspection/details_inspection_page.dart';
import '../inspections_controller.dart';
import 'card_percent_widget.dart';
import 'inspection_content_widget.dart';

class InspectionWidget extends StatelessWidget {
  const InspectionWidget({
    Key? key,
    required this.inspection,
  }) : super(key: key);

  final InspectionModel inspection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            DetailsInspectionPage.route,
            arguments: DetailsInspectionPageArguments(
              inspection,
              Get.find<InspectionsController>().routeArguments!.project,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 8,
              height: 120,
              color: inspection.getColor,
            ),
            Expanded(
              child: InspectionContentWidget(
                inspection: inspection,
              ),
            ),
            Column(
              children: [
                CardPercentWidget(
                  progress: inspection.getProgress,
                  color: inspection.getColor,
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(
                      NewInspectionPage.route,
                      arguments: NewInspectionPageArguments(
                        Get.find<InspectionsController>()
                            .routeArguments!
                            .project,
                        isItDuplication: true,
                        inspectionRequest: InspectionRequestModel(
                          id: inspection.id,
                          userId: inspection.userId,
                          activityId: inspection.activityId,
                          projectId: inspection.projectId,
                          tensionLevelId: inspection.tensionLevelId,
                          installationId: inspection.installationId,
                          installationTypeId: inspection.installationTypeId,
                          equipmentCategoryId: inspection.equipmentCategoryId,
                          towerId: inspection.towerId,
                          equipmentId: inspection.equipmentId,
                          stepId: inspection.stepId,
                          createdAt: inspection.createdAt,
                          updatedAt: inspection.updatedAt,
                          date: inspection.date,
                          audios: inspection.audios ?? [],
                          photos: inspection.photos ?? [],
                          answers: inspection.answers ?? [],
                          progress: inspection.progress,
                          name: inspection.name,
                          description: inspection.description,
                          comments: inspection.comments,
                          longitude: inspection.longitude!,
                          latitude: inspection.latitude!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
