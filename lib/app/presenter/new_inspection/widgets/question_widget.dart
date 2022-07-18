import 'package:flutter/material.dart';

import '../../../infra/enums/question_types_enum.dart';
import '../../../infra/models/responses/questionnary_model.dart';
import '../new_inspection_controller.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  const QuestionWidget(this.question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(
                question.description,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Visibility(
                visible: question.isRequired,
                child: Text(
                  " (obrigatório)",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: question.questionType == QuestionTypesEnum.yesorno,
            child: DropdownButtonFormField(
              value: _getValueYesOrNo(question),
              items: const [
                DropdownMenuItem(value: true, child: Text("Sim")),
                DropdownMenuItem(value: false, child: Text("Não"))
              ],
              onChanged: (value) {
                NewInspectionController.to.setAnswer(question, "$value");
              },
            ),
          ),
          Visibility(
            visible: question.questionType == QuestionTypesEnum.closed,
            child: DropdownButtonFormField(
              items: question.alternatives.length > 1
                  ? question.alternatives.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.description),
                      );
                    }).toList()
                  : null,
              onChanged: (value) {
                NewInspectionController.to.setAnswer(
                  question,
                  value,
                );
              },
            ),
          ),
          Visibility(
            visible: question.questionType == QuestionTypesEnum.open,
            child: TextFormField(
              onChanged: (value) {
                NewInspectionController.to.setAnswer(
                  question,
                  value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool? _getValueYesOrNo(Question question) {
    final value = NewInspectionController.to.answers.where((e) {
      return e.questionId == question.id;
    });

    if (question.questionType != QuestionTypesEnum.yesorno) {
      return null;
    }

    if (value.isNotEmpty) {
      if (value.first.answer is String) {
        return value.first.answer == 'true';
      }
      return value.first.answer.answer == "true";
    }
    return null;
  }
}
