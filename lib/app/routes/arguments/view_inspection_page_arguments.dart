import 'package:fisplan_alupar/app/infra/models/responses/inspection_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/project_model.dart';

class ViewInspectionPageArguments {
  ViewInspectionPageArguments(
    this.inspection,
    this.project,
  );

  final InspectionModel inspection;
  final ProjectModel project;
}
