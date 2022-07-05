import 'package:fisplan_alupar/app/infra/models/requests/inspection_request_model.dart';

import '../../infra/models/responses/project_model.dart';

class NewInspectionPageArguments {
  final ProjectModel project;
  final InspectionRequestModel? inspectionRequest;
  final bool isItDuplication;
  
  NewInspectionPageArguments(
    this.project, {
    this.inspectionRequest,
    this.isItDuplication=false,
  });
}
