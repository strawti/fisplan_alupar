import 'package:fisplan_alupar/app/infra/enums/question_types_enum.dart';
import 'package:fisplan_alupar/app/infra/models/responses/questionnary_model.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  const QuestionWidget(this.question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (question.questionType == QuestionTypesEnum.open) {
      return TextField(
        decoration: InputDecoration(
          labelText: question.name,
        ),
      );
    }

    if (question.questionType == QuestionTypesEnum.closed) {
      return Column(
        children: question.alternatives.map((option) {
          return CheckboxListTile(
            title: Text(option.description),
            value: false,
            onChanged: (value) {},
          );
        }).toList(),
      );
    }

    return ListTile(
      title: Text(question.description),
    );
  }
}
