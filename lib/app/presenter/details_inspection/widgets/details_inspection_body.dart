import 'audios_details_inspection_widget.dart';
import 'filters_details_inspection_widget.dart';
import 'question_details_inspection_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/location_inspection_widget.dart';
import '../../../shared/widgets/textform_widget.dart';
import '../../new_inspection/widgets/new_inspection_card.dart';
import '../details_inspection_controller.dart';
import 'photos_details_inspection_widget.dart';

class DetailspectionBody extends GetView<DetailsInspectionController> {
  const DetailspectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Você está visualizando a inspeção ',
            ),
            Text(
              controller.arguments.inspection.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              ' do projeto:',
            ),
            Text(
              controller.arguments.project.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const FiltersDetailsInspectionWidget(),
            const SizedBox(height: 10),
            const QuestionsDetailsInpectionWidget(),
            const SizedBox(height: 10),
            const PhotosDetailsInspectionWidget(),
            const SizedBox(height: 10),
            const AudiosDetailsInspectionWidget(),
            const SizedBox(height: 10),
            LocationInspectionWidget<DetailsInspectionController>(
              control: controller,
            ),
            const NewInspectionCard(
              title: 'Comentários',
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormWidget(
                  enabled: false,
                  hintText: 'Informações adicionais',
                  maxLines: 3,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
