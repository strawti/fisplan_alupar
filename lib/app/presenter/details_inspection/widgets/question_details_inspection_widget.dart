import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../new_inspection/widgets/new_inspection_card.dart';
import '../details_inspection_controller.dart';

class QuestionsDetailsInpectionWidget extends StatelessWidget {
  const QuestionsDetailsInpectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsInspectionController>(
      builder: (control) {
        return Visibility(
          visible: control.showQuestionnaries,
          replacement: const SizedBox.shrink(),
          child: NewInspectionCard(
            title: 'Perguntas',
            child: Column(
              children: control.questions.map(
                (question) {
                  return ListTile(
                    title: Text(question.description),
                    subtitle: Text(
                      control.getAnswer(question)?.getAnswer ?? '',
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}