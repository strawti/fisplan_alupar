import 'package:fisplan_alupar/app/core/app_token.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/audios_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_validators.dart';
import '../../../shared/widgets/textform_widget.dart';
import '../../new_inspection/widgets/new_inspection_card.dart';
import '../../new_inspection/widgets/tower_widget.dart';
import '../../new_inspection/widgets/view_image_widget.dart';
import '../details_inspection_controller.dart';

class DetailspectionBody extends GetView<DetailsInspectionController> {
  const DetailspectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Você está visualizando a inspeção ',
            ),
            Text(
              controller.arguments.inspection.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              ' do projeto:',
            ),
            Text(
              controller.arguments.project.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Filtros',
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormWidget(
                    enabled: false,
                    controller: controller.nameController,
                    labelText: 'Nome',
                    hintText: 'Nome da inspeção',
                    validator: simpleValidate,
                  ),
                  const SizedBox(height: 20),
                  TextFormWidget(
                    enabled: false,
                    controller: controller.descriptionController,
                    labelText: 'Descrição',
                    hintText: 'Informe a descrição da inspeção',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return ListTile(
                        title: const Text('Tipo de Instalação'),
                        subtitle: Text(
                          controller.selectedInstallationType?.name ?? '',
                          textScaleFactor: 1.1,
                        ),
                      );
                    },
                  ),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.showInstallation,
                        child: ListTile(
                          title: const Text('Instalação'),
                          subtitle: Text(
                            controller.selectedInstallation?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.showTower,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Torre'),
                              subtitle: Text(
                                controller.selectedTower?.name ?? '',
                                textScaleFactor: 1.1,
                              ),
                            ),
                            if (controller.selectedTower != null)
                              TowerWidget(
                                tower: controller.selectedTower!,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.showEquipmentCategory,
                        child: ListTile(
                          title: const Text('Categoria do equipamento'),
                          subtitle: Text(
                            controller.selectedEquipmentsCategory?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.showTensionLevel,
                        child: ListTile(
                          title: const Text('Nível de tensão'),
                          subtitle: Text(
                            controller.selectedTensionLevel?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.showEquipment,
                        child: ListTile(
                          title: const Text('Equipamento'),
                          subtitle: Text(
                            controller.selectedEquipment?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.showStep,
                        child: ListTile(
                          title: const Text('Etapa'),
                          subtitle: Text(
                            controller.selectedStep?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.showActivity,
                        child: ListTile(
                          title: const Text('Atividade'),
                          subtitle: Text(
                            controller.selectedActivity?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // GetBuilder<DetailsInspectionController>(
            //   builder: (control) {
            //     return Visibility(
            //       visible: control.showQuestionnaries,
            //       replacement: const SizedBox.shrink(),
            //       child: NewInspectionCard(
            //         title: 'Perguntas',
            //         child: Column(
            //           children: control.questions.map(
            //             (question) {
            //               return QuestionWidget(question);
            //             },
            //           ).toList(),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Foto',
              child:
                  GetBuilder<DetailsInspectionController>(builder: (control) {
                return Column(
                  children: control.inspection.photos!.map(
                    (image) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => ViewImageWidget(
                                    image: image.path,
                                  ),
                                );
                              },
                              child: Hero(
                                tag: image.path,
                                child: Image.network(
                                  image.path,
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                  headers: {
                                    'Authorization':
                                        'Bearer ${AppToken.instance.token}',
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                );
              }),
            ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Áudios',
              child: GetBuilder<AudiosController>(
                builder: (control) {
                  return Column(
                    children: control.audioPlayers.map((a) {
                      return StreamBuilder<Duration?>(
                        stream: a.player.positionStream,
                        builder: (context, snapshot) {
                          return Card(
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  a.isPlaying ? Icons.pause : Icons.play_arrow,
                                ),
                                onPressed: () {
                                  if (a.isPlaying) {
                                    control.stopAudio(a);
                                  } else {
                                    control.playAudio(a);
                                  }
                                },
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Slider(
                                    onChanged: (v) {
                                      a.player.seek(
                                        Duration(
                                          seconds: v.toInt(),
                                        ),
                                      );
                                    },
                                    value:
                                        snapshot.data?.inSeconds.toDouble() ??
                                            0.0,
                                    max: a.player.duration?.inSeconds
                                            .toDouble() ??
                                        0.0,
                                    min: 0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      "00:00:${snapshot.data?.inSeconds.toString().padLeft(2, '0')}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            //const LocationNewInspectionWidget(),
            const NewInspectionCard(
              title: 'Comentários',
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormWidget(
                  enabled: false,
                  hintText: 'Informações adicionais',
                  maxLines: 3,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
