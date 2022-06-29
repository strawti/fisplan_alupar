import 'package:fisplan_alupar/app/infra/models/responses/questionnary_model.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/new_inspection_controller.dart';
import 'package:flutter/material.dart';

import '../../../infra/enums/question_types_enum.dart';

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
                        child: Text("${e.description}%"),
                      );
                    }).toList()
                  : null,
              onChanged: (value) {
                NewInspectionController.to.setAnswer(question, value);
              },
            ),
          ),
          Visibility(
            visible: question.questionType == QuestionTypesEnum.open,
            child: TextFormField(
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
