import 'package:fisplan_alupar/app/infra/models/requests/inspection_request_model.dart';

import '../../infra/models/responses/project_model.dart';

class NewInspectionPageArguments {
  final ProjectModel project;
  final InspectionRequestModel? inspectionRequest;
  NewInspectionPageArguments(
    this.project, {
    this.inspectionRequest,
  });
}
