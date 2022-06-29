import 'dart:async';

import 'package:fisplan_alupar/app/infra/enums/question_types_enum.dart';
import 'package:fisplan_alupar/app/infra/models/requests/inspection_request_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/activity_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/answer_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/audio_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/photo_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/questionnary_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/step_model.dart';
import 'package:fisplan_alupar/app/presenter/home/home_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/activities_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/audios_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/images_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/questionnaires_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/steps_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../infra/models/defaults/item_selection_model.dart';
import '../../infra/models/responses/equipment_category_model.dart';
import '../../infra/models/responses/equipment_model.dart';
import '../../infra/models/responses/installation_model.dart';
import '../../infra/models/responses/installation_type_model.dart';
import '../../infra/models/responses/tension_level_model.dart';
import '../../infra/models/responses/tower_model.dart';
import '../../routes/arguments/new_inspection_page_arguments.dart';
import '../../routes/arguments/selection_page_arguments.dart';
import '../../shared/utils/custom_snackbar.dart';
import '../inspections/inspections_controller.dart';
import '../selection_page/selection_page.dart';
import 'controllers/companies_controller.dart';
import 'controllers/equipments_categories_controller.dart';
import 'controllers/equipments_controller.dart';
import 'controllers/installation_type_controller.dart';
import 'controllers/installations_controller.dart';
import 'controllers/towers_controller.dart';

class NewInspectionController extends GetxController {
  static NewInspectionController get to => Get.find();

  NewInspectionController() {
    assert(
      Get.arguments is NewInspectionPageArguments,
      "Passe NewInspectionPageArguments nos argumentos da rota",
    );

    arguments = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();

    nameController.addListener(update);
    descriptionController.addListener(update);

    _getPosition();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    positionStream?.cancel();
    super.onClose();
  }

  final nameController = TextEditingController();
  String get name => nameController.text.trim();

  final descriptionController = TextEditingController();
  String get description => descriptionController.text.trim();

  StreamSubscription<Position>? positionStream;
  Position? position;

  Future _getPosition() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Geolocator.getPositionStream().listen((pos) {
        position = pos;
        update();
      });
    } else {
      await Geolocator.requestPermission();
      CustomSnackbar.to.show("Permissão de localização negada");
    }
  }

  late NewInspectionPageArguments arguments;

  final instalationTypeController = Get.find<InstallationTypeController>();
  final installationsController = Get.find<InstallationsController>();
  final towersController = Get.find<TowersController>();
  final companiesController = Get.find<CompaniesController>();
  final equipmentController = Get.find<EquipmentsController>();
  final inspectionsController = Get.find<InspectionsController>();

  final equipmentsCategoryController =
      Get.find<EquipmentsCategoriesController>();

  InstallationTypeModel? selectedInstallationType;
  Future getInstallationType() async {
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Selecione o tipo de instalação',
      instalationTypeController.installationTypesFiltered,
      selectedInstallationType,
    );

    if (result != null) {
      selectedInstallationType = result.item;
      clearSelectedItems();
      update();
    }
  }

  InstallationModel? selectedInstallation;
  Future getInstallation() async {
    installationsController.filterByInstallationTypeId(
        selectedInstallationType!.id,
        inspectionsController.routeArguments!.project.id);

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Instalação',
      installationsController.installationsFiltered,
      selectedInstallation,
    );

    if (result != null) {
      clearSelectedItems();
      selectedInstallation = result.item;
      update();
    }
  }

  TowerModel? selectedTower;
  Future getTowers() async {
    towersController.filterTowersByInstallation(selectedInstallation!.id);

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Torre',
      towersController.towersFiltered,
      selectedTower,
    );

    if (result != null) {
      selectedTower = result.item;
      update();
    }
  }

  EquipmentCategoryModel? selectedEquipmentsCategory;
  Future getEquipmentsCategory() async {
    equipmentsCategoryController
        .filterCategoriesByInstallationId(selectedInstallation!.id);
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Categoria do equipamento',
      equipmentsCategoryController.equipmentsCategoriesFiltered,
      selectedEquipmentsCategory,
    );

    if (result != null) {
      selectedEquipmentsCategory = result.item;
      selectedTensionLevel = null;
      update();
    }
  }

  TensionLevelModel? selectedTensionLevel;
  Future getTensionLevel() async {
    companiesController.filterByProjectAndEquipmentCategory(
      arguments.project.id,
      selectedEquipmentsCategory!.id,
    );

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Nível de tensão',
      companiesController.tensionLevelsFiltered,
      selectedTensionLevel,
    );

    if (result != null) {
      selectedTensionLevel = result.item;
      update();
    }
  }

  EquipmentModel? selectedEquipment;
  Future getEquipments() async {
    equipmentController.filterEquipments(
      selectedEquipmentsCategory!.id,
      selectedInstallation!.id,
      selectedTensionLevel!.id,
    );

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Equipamento',
      equipmentController.equipmentsFiltered,
      selectedEquipment,
    );

    if (result != null) {
      selectedEquipment = result.item;
      update();
    }
  }

  StepModel? selectedStep;
  Future getSteps() async {
    StepsController.to.filterByEquipmentCategoryAndInstallationTypeAndProject(
      selectedEquipmentsCategory?.id,
      selectedInstallationType!.id,
      arguments.project.id,
    );

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Etapa',
      StepsController.to.stepsFiltered,
      selectedStep,
    );

    if (result != null) {
      selectedStep = result.item;
      update();
    }
  }

  ActivityModel? selectedActivity;
  Future getActivities() async {
    ActivitiesController.to.filterByStep(selectedStep!.id);

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Atividade',
      ActivitiesController.to.activitiesFiltered,
      selectedActivity,
    );

    if (result != null) {
      selectedActivity = result.item;
      getQuestionnaries();
      update();
    }
  }

  List<Question> questions = [];
  List<AnswerModel> answers = [];

  Future getQuestionnaries() async {
    QuestionnairesController.to.filterByProjectId(arguments.project.id);
    questions = QuestionnairesController.to.filterBy(
      selectedEquipmentsCategory!.id,
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

  void clearSelectedItems() {
    selectedTower = null;
    selectedEquipmentsCategory = null;
    selectedTensionLevel = null;
    selectedActivity = null;
    selectedEquipment = null;
    selectedStep = null;
    selectedInstallation = null;
  }

  Future goToSelectionPage(String title, List data, dynamic item) async {
    return await Get.toNamed(
      SelectionPage.route,
      arguments: SelectionPageArguments(
        title: title,
        items: data.map(
          (e) {
            return ItemSelectionModel(
              title: e.name,
              item: e,
              isChecked: item == e,
            );
          },
        ).toList(),
      ),
    );
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
        selectedEquipmentsCategory != null &&
        (selectedInstallationType!.id == 3 ||
            selectedInstallationType!.id == 2);
  }

  bool get showEquipment {
    return selectedTensionLevel != null &&
        (selectedInstallationType!.id == 3 ||
            selectedInstallationType!.id == 2);
  }

  bool get showStep {
    return selectedInstallation != null &&
        selectedInstallationType != null &&
        selectedEquipment != null;
  }

  bool get showActivity {
    return selectedStep != null;
  }

  bool get showQuestionnaries {
    return selectedActivity != null;
  }

  void verify() {
    if (name.isEmpty) {
      CustomSnackbar.to.show("Preencha o nome");
      return;
    }

    if (showInstallation) {
      if (selectedInstallation == null) {
        CustomSnackbar.to.show("Selecione uma instalação");
        return;
      }
    }

    if (showTower) {
      if (selectedTower == null) {
        CustomSnackbar.to.show("Selecione uma torre");
        return;
      }
    }

    if (showEquipmentCategory) {
      if (selectedEquipmentsCategory == null) {
        CustomSnackbar.to.show("Selecione uma categoria de equipamento");
        return;
      }
    }

    if (showTensionLevel) {
      if (selectedTensionLevel == null) {
        CustomSnackbar.to.show("Selecione um nível de tensão");
        return;
      }
    }

    if (showEquipment) {
      if (selectedEquipment == null) {
        CustomSnackbar.to.show("Selecione um equipamento");
        return;
      }
    }

    if (showStep) {
      if (selectedStep == null) {
        CustomSnackbar.to.show("Selecione uma etapa");
        return;
      }
    }

    if (showActivity) {
      if (selectedActivity == null) {
        CustomSnackbar.to.show("Selecione uma atividade");
        return;
      }
    }

    if (showQuestionnaries) {
      if (questions.where((e) => e.isRequired).length == answers.length) {
        CustomSnackbar.to.show("Responda todas as perguntas obrigatórias");
        return;
      }
    }

    saveInspection();
  }

  Future saveInspection() async {
    List<AudioModel> audios = [];
    final audiosAsBase64 =
        await Get.find<AudiosController>().getAudiosInBase64();
    audios.addAll(audiosAsBase64.map((e) => AudioModel(path: e)));

    List<PhotoModel> photos = [];
    final photosAsBase64 =
        await Get.find<ImagesController>().getImagesInBase64();
    photos.addAll(photosAsBase64.map((e) => PhotoModel(path: e)));

    double progress = 0;
    if (answers.isNotEmpty) {
      int questionsYESORNOCount = 0; // only this.questionTypes.YESORNO
      int questionsDoneCount = 0; // only this.questionTypes.YESORNO

      for (int i = 0; i < answers.length; i++) {
        final question = questions.where((e) {
          return e.id == answers[i].questionId;
        }).first;

        dynamic answer = answers[i];

        if (question.questionType == QuestionTypesEnum.yesorno) {
          if (answer == '') {
            answer = "false";
          }

          questionsYESORNOCount += 1;

          if (answer == "true") {
            questionsDoneCount += 1;
          }
        }
      }

      progress = (questionsDoneCount / questionsYESORNOCount) * 100;
    } else {
      progress = 100;
    }

    final request = InspectionRequestModel(
      HomeController.to.user!.id,
      selectedActivity!.id,
      arguments.project.id,
      selectedTensionLevel?.id,
      selectedInstallation!.id,
      selectedInstallationType!.id,
      selectedEquipmentsCategory?.id,
      selectedTower?.id,
      selectedEquipment?.id,
      selectedStep!.id,
      DateTime.now(),
      DateTime.now(),
      audios,
      photos,
      answers,
      progress,
      name,
      description,
    );
  }
}
