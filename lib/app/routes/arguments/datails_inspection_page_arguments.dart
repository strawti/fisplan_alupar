import '../../infra/models/responses/inspection_model.dart';
import '../../infra/models/responses/project_model.dart';

class DetailsInspectionPageArguments {
  DetailsInspectionPageArguments(
    this.inspection,
    this.project,
  );

  final InspectionModel inspection;
  final ProjectModel project;
}
