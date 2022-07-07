import 'package:fisplan_alupar/app/infra/models/responses/inspection_model.dart';
import 'package:fisplan_alupar/app/shared/controllers/companies_controller.dart';
import 'package:fisplan_alupar/app/shared/controllers/installations_controller.dart';
import 'package:fisplan_alupar/app/routes/arguments/datails_inspection_page_arguments.dart';
import 'package:fisplan_alupar/app/shared/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/responses/activity_model.dart';
import '../../infra/models/responses/answer_model.dart';
import '../../infra/models/responses/equipment_category_model.dart';
import '../../infra/models/responses/equipment_model.dart';
import '../../infra/models/responses/installation_model.dart';
import '../../infra/models/responses/installation_type_model.dart';
import '../../infra/models/responses/questionnary_model.dart';
import '../../infra/models/responses/step_model.dart';
import '../../infra/models/responses/tension_level_model.dart';
import '../../infra/models/responses/tower_model.dart';
import '../../routes/arguments/datails_inspection_page_arguments.dart';
import '../inspections/inspections_controller.dart';
import '../../shared/controllers/activities_controller.dart';
import '../../shared/controllers/equipments_categories_controller.dart';
import '../../shared/equipments_controller.dart';
import '../../shared/controllers/installation_type_controller.dart';
import '../../shared/controllers/questionnaires_controller.dart';
import '../../shared/controllers/steps_controller.dart';
import '../../shared/controllers/towers_controller.dart';

class DetailsInspectionController extends GetxController {
  DetailsInspectionController() {
    assert(
      Get.arguments is DetailsInspectionPageArguments,
      "Passe DetailsInspectionPageArguments nos argumentos da rota",
    );

    arguments = Get.arguments;
  }

  late DetailsInspectionPageArguments arguments;
  InspectionModel get inspection => arguments.inspection;

  @override
  void onReady() {
    super.onReady();

    nameController.addListener(update);
    descriptionController.addListener(update);
    commentsController.addListener(update);

    _fillTheFields();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();

    commentsController.dispose();
    super.onClose();
  }

  Future _fillTheFields() async {
    final inspection = arguments.inspection;

    CustomDialog().show(
      title: 'Aguarde',
      middleText: 'Obtendo dados...',
    );
    await Future.delayed(const Duration(seconds: 2));
    Get.back();

    nameController.text = inspection.name;

    descriptionController.text = inspection.description ?? '';

    selectedInstallation =
        installationsController.installationsFiltered.firstWhereOrNull((e) {
      return e.id == inspection.installationId;
    });

    selectedInstallationType = instalationTypeController
        .installationTypesFiltered
        .firstWhereOrNull((e) {
      return e.id == inspection.installationTypeId;
    });

    selectedTower = towersController.towersFiltered.firstWhereOrNull(
      (e) => e.id == inspection.towerId,
    );

    selectedActivity =
        ActivitiesController.to.activitiesFiltered.firstWhereOrNull(
      (e) {
        return e.id == inspection.activityId;
      },
    );

    selectedEquipment =
        equipmentController.equipmentsFiltered.firstWhereOrNull((e) {
      return e.id == inspection.equipmentId;
    });

    selectedEquipmentsCategory = equipmentsCategoryController
        .equipmentsCategoriesFiltered
        .firstWhereOrNull((e) {
      return e.id == inspection.equipmentCategoryId;
    });

    selectedStep = StepsController.to.stepsFiltered.firstWhereOrNull((e) {
      return e.id == inspection.stepId;
    });

    selectedTensionLevel =
        companiesController.tensionLevelsFiltered.firstWhereOrNull((e) {
      return e.id == inspection.tensionLevelId;
    });

    getQuestionnaries();

    for (var q in questions) {
      final answer = inspection.answers!.where((e) {
        return q.id == e.questionId && q.questionnaireId == e.questionnaireId;
      });

      if (answer.isNotEmpty) {
        setAnswer(q, answer.first);
      }
    }

    commentsController.text = inspection.comments ?? '';
  }

  final nameController = TextEditingController();
  String get name => nameController.text.trim();

  final descriptionController = TextEditingController();
  String get description => descriptionController.text.trim();

  final commentsController = TextEditingController();
  String get comments => commentsController.text.trim();

  final instalationTypeController = Get.find<InstallationTypeController>();
  final installationsController = Get.find<InstallationsController>();
  final towersController = Get.find<TowersController>();
  final companiesController = Get.find<CompaniesTensionLevelController>();
  final equipmentController = Get.find<EquipmentsController>();
  final inspectionsController = Get.find<InspectionsController>();
  final equipmentsCategoryController =
      Get.find<EquipmentsCategoriesController>();

  InstallationTypeModel? selectedInstallationType;
  InstallationModel? selectedInstallation;
  TowerModel? selectedTower;
  EquipmentCategoryModel? selectedEquipmentsCategory;
  TensionLevelModel? selectedTensionLevel;
  EquipmentModel? selectedEquipment;
  StepModel? selectedStep;
  ActivityModel? selectedActivity;

  List<Question> questions = [];
  List<AnswerModel> answers = [];

  Future getQuestionnaries() async {
    QuestionnairesController.to.filterByProjectId(arguments.project.id);
    questions = QuestionnairesController.to.filterBy(
      selectedEquipmentsCategory?.id,
      selectedActivity!.id,
      selectedStep!.id,
    );

    update();
  }

  void setAnswer(Question question, dynamic answer) {
    answers.removeWhere((e) => e.questionId == question.id);

    answers.add(
      AnswerModel(
        questionnaireId:
            QuestionnairesController.to.questionnairesFiltered.first.id,
        questionId: question.id,
        answer: answer,
      ),
    );

    update();
  }

  AnswerModel? getAnswer(Question question) {
    final answer = answers.where((e) => e.questionId == question.id);

    if (answer.isNotEmpty) {
      return answer.first;
    }

    return null;
  }

  bool get showInstallation {
    return selectedInstallationType != null;
  }

  bool get showTower {
    return selectedInstallation != null &&
        (selectedInstallationType!.id == 5 ||
            selectedInstallationType!.id == 4 ||
            selectedInstallationType!.id == 1);
  }

  bool get showEquipmentCategory {
    return selectedInstallation != null &&
        (selectedInstallationType!.id == 3 ||
            selectedInstallationType!.id == 2);
  }

  bool get showTensionLevel {
    return selectedEquipmentsCategory != null &&
        (selectedInstallationType!.id == 3 ||
            selectedInstallationType!.id == 2);
  }

  bool get showEquipment {
    return selectedTensionLevel != null &&
        (selectedInstallationType!.id == 3 ||
            selectedInstallationType!.id == 2);
  }

  bool get showStep {
    return selectedInstallation != null && selectedEquipmentsCategory != null ||
        selectedTower != null;
  }

  bool get showActivity {
    // TODO verificar condição de exibição desse campo
    return selectedStep != null;
  }

  bool get showQuestionnaries {
    return selectedActivity != null;
  }
}
