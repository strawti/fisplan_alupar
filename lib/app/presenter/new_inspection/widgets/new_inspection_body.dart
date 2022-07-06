import 'package:fisplan_alupar/app/core/app_validators.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/images_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/question_widget.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/tower_widget.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/view_image_widget.dart';
import 'package:fisplan_alupar/app/shared/widgets/button_default_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/textform_widget.dart';
import '../controllers/audios_controller.dart';
import '../new_inspection_controller.dart';
import 'location_new_inspection_widget.dart';
import 'new_inspection_card.dart';
import 'record_audio_widget.dart';

class NewInspectionBody extends StatelessWidget {
  const NewInspectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleWidget(),
            const SizedBox(height: 10),
            Text(
              Get.find<NewInspectionController>().arguments.project.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const FiltersWidget(),
            const SizedBox(height: 10),
            GetBuilder<NewInspectionController>(
              builder: (control) {
                return Visibility(
                  visible: control.showQuestionnaries,
                  replacement: const SizedBox.shrink(),
                  child: NewInspectionCard(
                    title: 'Perguntas',
                    child: Column(
                      children: control.questions.map(
                        (question) {
                          return QuestionWidget(question);
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const PhotosWidget(),
            const SizedBox(height: 10),
            const AudiosWidget(),
            const SizedBox(height: 10),
            const LocationNewInspectionWidget(),
            const NewInspectionCard(
              title: 'Comentários',
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormWidget(
                  hintText: 'Informações adicionais',
                  maxLines: 3,
                ),
              ),
            ),
            const SizedBox(height: 40),
            GetBuilder<NewInspectionController>(
              builder: (control) {
                return ButtonDefaultWidget(
                  title: control.arguments.inspectionRequest != null &&
                          control.arguments.isItDuplication == false
                      ? "Salvar Alteração"
                      : "Salvar",
                  onTap: control.verify,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
