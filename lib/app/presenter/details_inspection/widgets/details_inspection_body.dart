import 'package:fisplan_alupar/app/shared/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../new_inspection/controllers/audios_controller.dart';
import '../../new_inspection/controllers/images_controller.dart';
import '../../new_inspection/widgets/new_inspection_card.dart';
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text('Nome'),
                  Text(controller.arguments.inspection.name),
                  const SizedBox(height: 20),
                  const Text('Descrição'),
                  Text(controller.arguments.inspection.description ?? ''),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text('Tipo de Instalação'),
                    subtitle: Text(
                      controller.arguments.inspection.name,
                      textScaleFactor: 1.1,
                    ),
                  ),
                  const DividerWidget(),
                  Visibility(
                    visible:
                        controller.arguments.inspection.description != null,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Instalação'),
                          subtitle: Text(
                            controller.arguments.inspection.installationId
                                .toString(),
                            textScaleFactor: 1.1,
                          ),
                        ),
                        const DividerWidget(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.arguments.inspection.towerId != null,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Torre'),
                          subtitle: Text(
                            controller.arguments.inspection.towerName ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                        const DividerWidget(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        controller.arguments.inspection.equipmentCategoryId !=
                            null,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Categoria do equipamento'),
                          subtitle: Text(
                            controller.arguments.inspection.equipmentName,
                            textScaleFactor: 1.1,
                          ),
                        ),
                        const DividerWidget(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        controller.arguments.inspection.tensionLevelId != null,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Nível de tensão'),
                          subtitle: Text(
                            controller.arguments.inspection.towerName ?? '',
                            textScaleFactor: 1.1,
                          ),
                        ),
                        const DividerWidget(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        controller.arguments.inspection.equipmentId != null,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Equipamento'),
                          subtitle: Text(
                            controller.arguments.inspection.equipmentName,
                            textScaleFactor: 1.1,
                          ),
                        ),
                        const DividerWidget(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.arguments.inspection.stepId != null,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Etapa'),
                          subtitle: Text(
                            controller.arguments.inspection.stepName,
                            textScaleFactor: 1.1,
                          ),
                        ),
                        const DividerWidget(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.arguments.inspection.activityId != null,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Atividade'),
                          subtitle: Text(
                            controller.arguments.inspection.activityName,
                            textScaleFactor: 1.1,
                          ),
                        ),
                        const DividerWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            NewInspectionCard(
              title: 'Fotos',
              child: GetBuilder<ImagesController>(builder: (control) {
                return Column(
                  children: control.allImages.map(
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
                                    image: image,
                                  ),
                                );
                              },
                              child: Hero(
                                tag: image.path,
                                child: Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                image.path.split('/').last,
                                textScaleFactor: 0.9,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
            NewInspectionCard(
              title: 'Comentarios',
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  controller.arguments.inspection.comments ?? '',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
