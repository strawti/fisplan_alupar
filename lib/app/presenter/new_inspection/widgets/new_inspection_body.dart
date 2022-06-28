import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/images_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/view_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/textform_widget.dart';
import '../controllers/audios_controller.dart';
import '../new_inspection_controller.dart';
import 'location_new_inspection_widget.dart';
import 'new_inspection_card.dart';
import 'record_audio_widget.dart';

class NewInspectionBody extends StatelessWidget {
  const NewInspectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Você está criando uma nova inspeção para o projeto:'),
            const SizedBox(height: 10),
            Text(
              Get.find<NewInspectionController>().arguments.project.name,
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
                  const TextFormWidget(
                    labelText: 'Nome',
                    hintText: 'Nome da inspeção',
                  ),
                  const SizedBox(height: 20),
                  const TextFormWidget(
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
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return ListTile(
                        title: const Text('Tipo de Instalação'),
                        trailing: const Icon(Icons.arrow_drop_down),
                        subtitle: Text(
                          controller.selectedInstallationType?.name ?? '',
                          textScaleFactor: 1.1,
                        ),
                        onTap: controller.getInstallationType,
                      );
                    },
                  ),
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.selectedInstallationType != null,
                        child: ListTile(
                          title: const Text('Instalação'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          subtitle: Text(
                            controller.selectedInstallation?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                          onTap: controller.getInstallation,
                        ),
                      );
                    },
                  ),
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.selectedInstallation != null &&
                            (controller.selectedInstallationType!.id == 5 ||
                                controller.selectedInstallationType!.id == 4 ||
                                controller.selectedInstallationType!.id == 1),
                        child: ListTile(
                          title: const Text('Torre'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          subtitle: Text(
                            controller.selectedTower?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                          onTap: controller.getTowers,
                        ),
                      );
                    },
                  ),
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.selectedInstallation != null &&
                            (controller.selectedInstallationType!.id == 3 ||
                                controller.selectedInstallationType!.id == 2),
                        child: ListTile(
                          title: const Text('Categoria do equipamento'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          subtitle: Text(
                            controller.selectedEquipmentsCategory?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                          onTap: controller.getEquipmentsCategory,
                        ),
                      );
                    },
                  ),
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.selectedEquipmentsCategory !=
                                null &&
                            (controller.selectedInstallationType!.id == 3 ||
                                controller.selectedInstallationType!.id == 2),
                        child: ListTile(
                          title: const Text('Nível de tensão'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          subtitle: Text(
                            controller.selectedTensionLevel?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                          onTap: controller.getTensionLevel,
                        ),
                      );
                    },
                  ),
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.selectedTensionLevel != null &&
                            (controller.selectedInstallationType!.id == 3 ||
                                controller.selectedInstallationType!.id == 2),
                        child: ListTile(
                          title: const Text('Equipamento'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          subtitle: Text(
                            controller.selectedEquipment?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                          onTap: controller.getEquipments,
                        ),
                      );
                    },
                  ),
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible:
                            controller.selectedEquipmentsCategory != null &&
                                controller.selectedInstallationType != null,
                        child: ListTile(
                          title: const Text('Etapa'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          subtitle: Text(
                            controller.selectedStep?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                          onTap: controller.getSteps,
                        ),
                      );
                    },
                  ),
                  GetBuilder<NewInspectionController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.selectedStep != null,
                        child: ListTile(
                          title: const Text('Atividade'),
                          trailing: const Icon(Icons.arrow_drop_down),
                          subtitle: Text(
                            controller.selectedActivity?.name ?? '',
                            textScaleFactor: 1.1,
                          ),
                          onTap: controller.getActivities,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Foto',
              icon: IconButton(
                onPressed: Get.find<ImagesController>().addImages,
                icon: const Icon(Icons.camera_alt),
                color: Colors.black54,
              ),
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
                            TextButton(
                              onPressed: () {
                                control.removeImage(image);
                              },
                              child: const Text(
                                'Apagar',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
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
              icon: IconButton(
                onPressed: () {
                  Get.bottomSheet(const RecordAudioWidget());
                },
                icon: const Icon(Icons.mic_rounded),
                color: Colors.black54,
              ),
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
                              trailing: IconButton(
                                onPressed: () {
                                  control.removeAudioDialog(a);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
            const LocationNewInspectionWidget(),
            const NewInspectionCard(
              title: 'Comentarios',
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormWidget(
                  hintText: 'Informações adicionais',
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
