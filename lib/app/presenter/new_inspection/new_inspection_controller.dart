import 'dart:async';
import 'dart:developer';

import 'package:fisplan_alupar/app/shared/utils/ternary_clean.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../infra/enums/question_types_enum.dart';
import '../../infra/models/defaults/item_selection_model.dart';
import '../../infra/models/requests/inspection_request_model.dart';
import '../../infra/models/responses/activity_model.dart';
import '../../infra/models/responses/answer_model.dart';
import '../../infra/models/responses/audio_model.dart';
import '../../infra/models/responses/equipment_category_model.dart';
import '../../infra/models/responses/equipment_model.dart';
import '../../infra/models/responses/installation_model.dart';
import '../../infra/models/responses/installation_type_model.dart';
import '../../infra/models/responses/photo_model.dart';
import '../../infra/models/responses/questionnary_model.dart';
import '../../infra/models/responses/step_model.dart';
import '../../infra/models/responses/tension_level_model.dart';
import '../../infra/models/responses/tower_model.dart';
import '../../infra/providers/inspections/local_inspections_provider.dart';
import '../../routes/arguments/new_inspection_page_arguments.dart';
import '../../routes/arguments/selection_page_arguments.dart';
import '../../shared/controllers/activities_controller.dart';
import '../../shared/controllers/audios_controller.dart';
import '../../shared/controllers/companies_controller.dart';
import '../../shared/controllers/equipments_categories_controller.dart';
import '../../shared/controllers/equipments_controller.dart';
import '../../shared/controllers/images_controller.dart';
import '../../shared/controllers/installation_type_controller.dart';
import '../../shared/controllers/installations_controller.dart';
import '../../shared/controllers/questionnaires_controller.dart';
import '../../shared/controllers/steps_controller.dart';
import '../../shared/controllers/towers_controller.dart';
import '../../shared/utils/custom_dialog.dart';
import '../../shared/utils/custom_snackbar.dart';
import '../../shared/utils/get_datetime.dart';
import '../../shared/utils/loader_manager.dart';
import '../home/home_controller.dart';
import '../home/home_page.dart';
import '../inspections/inspections_controller.dart';
import '../selection_page/selection_page.dart';

class NewInspectionController extends GetxController with LoaderManager {
  static NewInspectionController get to => Get.find();

  final LocalInspectionsProvider _localProvider;

  NewInspectionController(
    this._localProvider,
  ) {
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
    commentsController.addListener(update);

    nameController.text =
        "Fiscaliza????o - ${formatDateTimeForString(DateTime.now())}";

    _getPosition();

    _fillTheFields();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    positionStream?.cancel();
    commentsController.dispose();
    HomeController.to.getInspectionsUnsynch();
    super.onClose();
  }

  final scrollController = ScrollController();

  Future _fillTheFields() async {
    final inspection = arguments.inspectionRequest;

    if (inspection == null) {
      return;
    }

    CustomDialog().showDialog(
      title: "Aguarde",
      middleText: TernaryClean(
        condition: arguments.isItDuplication,
        caseTrue:
            'Obtendo dados...\nImagens e ??udios s?? ser??o copiados se houver conex??o com a internet.',
        caseFalse: 'Obtendo dados...',
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    Get.back();

    if (arguments.isItDuplication == false) {
      nameController.text = inspection.name;
    }

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

    final selectedTower = towersController.towersFiltered.firstWhereOrNull(
      (e) => e.id == inspection.towerId?.first,
    );

    if (selectedTower != null) {
      selectedTowers = [selectedTower];
    }

    selectedActivity =
        ActivitiesController.to.activitiesFiltered.firstWhereOrNull(
      (e) {
        return e.id == inspection.activityId;
      },
    );

    final selectedEquipment =
        equipmentController.equipmentsFiltered.firstWhereOrNull((e) {
      return e.id == inspection.equipmentId?.first;
    });

    if (selectedEquipment != null) {
      selectedEquipments = [selectedEquipment];
    }

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

    getQuestionnaries().whenComplete(() {
      for (Question q in questions) {
        final answer = inspection.answers.where((e) {
          return q.id == e.questionId;
        });

        if (answer.isNotEmpty) {
          setAnswer(q, answer.first);
        }
      }
    });

    // Fotos
    if (arguments.isItDuplication == false) {
      Get.find<ImagesController>().setImagesInBase64(inspection.photos.map((e) {
        return e.path;
      }).toList());
    } else if (arguments.isItDuplication) {
      Get.find<ImagesController>().setImagesOfWeb(inspection.photos.map((e) {
        return e.path;
      }).toList());
    }

    // Audios
    if (arguments.isItDuplication == false) {
      Get.find<AudiosController>().setAudiosInBase64(inspection.audios.map((e) {
        return e.path;
      }).toList());
    } else if (arguments.isItDuplication) {
      Get.find<AudiosController>().setAudiosOfWeb(inspection.audios.map((e) {
        return e.path;
      }).toList());
    }

    commentsController.text = inspection.comments ?? '';
  }

  final nameController = TextEditingController();
  String get name => nameController.text.trim();

  final descriptionController = TextEditingController();
  String get description => descriptionController.text.trim();

  final commentsController = TextEditingController();
  String get comments => commentsController.text.trim();

  StreamSubscription<Position>? positionStream;
  Position? position;

  Future _getPosition() async {
    final permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.whileInUse ||
        permission != LocationPermission.always) {
      await Geolocator.requestPermission();
    }

    positionStream = Geolocator.getPositionStream().listen(
      (pos) {
        try {
          position = pos;
          update(['position']);
        } catch (e) {
          log('Problemas na localiza????o');
        }
      },
      cancelOnError: false,
    );
  }

  late NewInspectionPageArguments arguments;

  final instalationTypeController = Get.find<InstallationTypeController>();
  final installationsController = Get.find<InstallationsController>();
  final towersController = Get.find<TowersController>();
  final companiesController = Get.find<CompaniesTensionLevelController>();
  final equipmentController = Get.find<EquipmentsController>();
  final inspectionsController = Get.find<InspectionsController>();

  final equipmentsCategoryController =
      Get.find<EquipmentsCategoriesController>();

  InstallationTypeModel? selectedInstallationType;
  Future getInstallationType() async {
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Selecione o tipo de instala????o',
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
      'Instala????o',
      installationsController.installationsFiltered,
      selectedInstallation,
    );

    if (result != null) {
      clearSelectedItems();
      selectedInstallation = result.item;
      update();
    }
  }

  List<TowerModel>? selectedTowers;
  String get nameSelectedTowers {
    return selectedTowers?.map((t) => t.name).join(', ') ?? '';
  }

  Future getTowers() async {
    towersController.filterTowersByInstallation(selectedInstallation!.id);

    final result = await Get.toNamed(
      SelectionPage.route,
      arguments: SelectionPageArguments(
        title: 'Torres',
        isMultipleSelection: true,
        items: towersController.towersFiltered.map(
          (tower) {
            return ItemSelectionModel<TowerModel>(
              title: tower.name,
              item: tower,
              isChecked: selectedTowers?.where((e) {
                    return e.id == tower.id;
                  }).isNotEmpty ??
                  false,
            );
          },
        ).toList(),
      ),
    );

    if (result != null) {
      selectedTowers = List<TowerModel>.from(result.map((e) => e.item));

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
      selectedEquipments = null;
      selectedStep = null;
      selectedActivity = null;
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
      'N??vel de tens??o',
      companiesController.tensionLevelsFiltered,
      selectedTensionLevel,
    );

    if (result != null) {
      selectedTensionLevel = result.item;
      update();
    }
  }

  List<EquipmentModel>? selectedEquipments;
  String get nameSelectedEquipments {
    return selectedEquipments?.map((t) => t.name).join(', ') ?? '';
  }

  Future getEquipments() async {
    equipmentController.filterEquipments(
      selectedEquipmentsCategory!.id,
      selectedInstallation!.id,
      selectedTensionLevel!.id,
    );

    final result = await Get.toNamed(
      SelectionPage.route,
      arguments: SelectionPageArguments(
        title: 'Equipamento',
        isMultipleSelection: true,
        items: equipmentController.equipmentsFiltered.map(
          (tower) {
            return ItemSelectionModel<EquipmentModel>(
              title: tower.name,
              item: tower,
              isChecked: selectedEquipments?.where((e) {
                    return e.id == tower.id;
                  }).isNotEmpty ??
                  false,
            );
          },
        ).toList(),
      ),
    );

    if (result != null) {
      selectedEquipments = List<EquipmentModel>.from(result.map((e) => e.item));

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
      selectedActivity = null;
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

  String openAnswer = '';

  List<Question> questions = [];
  List<AnswerModel> answers = [];

  Future getQuestionnaries() async {
    QuestionnairesController.to.filterByProjectId(arguments.project.id);
    questions = QuestionnairesController.to.filterBy(
      selectedEquipmentsCategory?.id,
      selectedActivity!.id,
      selectedStep!.id,
    );

    answers.clear();

    update();
  }

  void setAnswer(Question question, dynamic answer) {
    answers.removeWhere((e) => e.questionId == question.id);

    if (answer is AnswerModel) {
      answers.add(answer.copyWith(
        questionnaireId: question.questionnaireId,
      ));
    } else {
      answers.add(
        AnswerModel(
          questionnaireId: question.questionnaireId,
          questionId: question.id,
          answer: answer is AlternativeModel ? answer.id : answer,
        ),
      );
    }

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
    selectedTowers = null;
    selectedEquipmentsCategory = null;
    selectedTensionLevel = null;
    selectedActivity = null;
    selectedEquipments = null;
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
        (selectedInstallationType!.id == 3 ||
            selectedInstallationType!.id == 2);
  }

  bool get showEquipment {
    return selectedTensionLevel != null &&
        (selectedInstallationType!.id == 3 ||
            selectedInstallationType!.id == 2);
  }

  bool get showStep {
    return selectedInstallationType != null &&
            selectedInstallation != null &&
            selectedEquipmentsCategory != null &&
            selectedEquipments != null &&
            selectedTensionLevel != null ||
        selectedTowers != null;
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
        CustomSnackbar.to.show("Selecione uma instala????o");
        return;
      }
    }

    if (showTower) {
      if (selectedTowers == null) {
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
        CustomSnackbar.to.show("Selecione um n??vel de tens??o");
        return;
      }
    }

    if (showEquipment) {
      if (selectedEquipments == null) {
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
      if (questions.where((e) => e.isRequired).length < answers.length) {
        CustomSnackbar.to.show("Responda todas as perguntas obrigat??rias");
        return;
      }
    }

    if (position == null) {
      CustomSnackbar.to.show("Precisamos da sua localiza????o para continuar!");

      _getPosition();
      return;
    }

    if (Get.find<ImagesController>().isLoading) {
      CustomSnackbar.to.show("As imagens ainda n??o foram baixadas!");
      return;
    }

    saveOrUpdateInspection();
  }

  void saveOrUpdateInspection() {
    if (arguments.inspectionRequest == null || arguments.isItDuplication) {
      saveInspection();
    } else {
      updateInspection();
    }
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

        dynamic answer = answers[i].answer;

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
      id: null,
      date: position!.timestamp.toString(),
      userId: HomeController.to.user!.id,
      activityId: selectedActivity?.id,
      projectId: arguments.project.id,
      tensionLevelId: selectedTensionLevel?.id,
      installationId: selectedInstallation!.id,
      installationTypeId: selectedInstallationType!.id,
      equipmentCategoryId: selectedEquipmentsCategory?.id,
      towerId: selectedTowers?.map((e) => e.id).toList(),
      equipmentId: selectedEquipments?.map((e) => e.id).toList(),
      stepId: selectedStep?.id,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      audios: audios,
      photos: photos,
      answers: answers,
      progress: progress,
      name: name,
      description: description,
      comments: comments,
      latitude: position!.latitude,
      longitude: position!.longitude,
      isSendPhotos: photos.isEmpty,
    );

    _getInspectionsUnsynchronized().then(
      (inspections) async {
        final response = await _localProvider.setUnsynchronized(
          [...inspections, request],
        );

        if (response.isSuccess) {
          await CustomDialog().showDialog(
            textConfirm: 'Sim',
            textCancel: 'N??o',
            title: 'Duplicar?',
            middleText: 'Deseja criar uma nova inspe????o a partir dessa?',
            onConfirm: () {
              Get.back();
              CustomSnackbar.to.show(
                "Inspe????o salva e duplicada com sucesso",
              );
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              );
              nameController.text =
                  "Fiscaliza????o - ${formatDateTimeForString(DateTime.now())}";
            },
            onCancel: () {
              Get.back();
              Get.offNamed(HomePage.route);
              CustomSnackbar.to.show("Inspe????o salva com sucesso");
            },
          );

          Get.find<InspectionsController>().fetch();
        } else {
          CustomSnackbar.to.show(response.error!.content!);
        }
      },
    );
  }

  Future updateInspection() async {
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

        dynamic answer = answers[i].answer;

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
      id: arguments.inspectionRequest!.id,
      date: position!.timestamp.toString(),
      userId: arguments.inspectionRequest!.userId,
      activityId: selectedActivity?.id,
      projectId: arguments.project.id,
      tensionLevelId: selectedTensionLevel?.id,
      installationId: selectedInstallation!.id,
      installationTypeId: selectedInstallationType!.id,
      equipmentCategoryId: selectedEquipmentsCategory?.id,
      towerId: selectedTowers?.map((e) => e.id).toList(),
      equipmentId: selectedEquipments?.map((e) => e.id).toList(),
      stepId: selectedStep?.id,
      createdAt: arguments.inspectionRequest!.createdAt,
      updatedAt: DateTime.now().toString(),
      audios: audios,
      photos: photos,
      answers: answers,
      progress: progress,
      name: name,
      description: description,
      comments: comments,
      latitude: position!.latitude,
      longitude: position!.longitude,
      isSendPhotos: photos.isEmpty,
    );

    _getInspectionsUnsynchronized().then(
      (inspections) async {
        final data = inspections;
        data.removeWhere((e) {
          return e.toMap() == arguments.inspectionRequest!.toMap();
        });

        data.removeWhere(
          (e) => e.createdAt == arguments.inspectionRequest!.createdAt,
        );

        final response = await _localProvider.setUnsynchronized(
          [...data, request],
        );

        if (response.isSuccess) {
          Get.offNamed(HomePage.route);
          Get.find<InspectionsController>().fetch();

          CustomSnackbar.to.show("Inspe????o atualizada com sucesso");
        } else {
          CustomSnackbar.to.show(response.error!.content!);
        }
      },
    );
  }

  Future<List<InspectionRequestModel>> _getInspectionsUnsynchronized() async {
    final response = await _localProvider.getAllUnsynchronized();
    if (response.isSuccess) {
      return response.data ?? [];
    }

    return [];
  }
}
