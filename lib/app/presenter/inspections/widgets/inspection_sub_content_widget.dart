import 'package:flutter/material.dart';

import '../../../infra/models/responses/inspection_model.dart';
import 'inspection_title_and_content_widget.dart';

class InspectionSubContentWidget extends StatelessWidget {
  const InspectionSubContentWidget({
    Key? key,
    required this.inspection,
  }) : super(key: key);

  final InspectionModel inspection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 65,
            color: Colors.grey,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InspectionTitleAndContentWidget(
                title: 'Torre: ',
                content: inspection.towerName ?? '',
              ),
              InspectionTitleAndContentWidget(
                title: 'Equipamento: ',
                content: inspection.equipmentName,
              ),
              InspectionTitleAndContentWidget(
                title: 'Etapa: ',
                content: inspection.stepName,
              ),
              InspectionTitleAndContentWidget(
                title: 'Atividade: ',
                content: inspection.activityName,
              ),
            ],
          )
        ],
      ),
    );
  }
}
