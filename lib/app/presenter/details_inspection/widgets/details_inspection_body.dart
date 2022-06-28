import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/textform_widget.dart';
import '../../new_inspection/controllers/audios_controller.dart';
import '../../new_inspection/controllers/images_controller.dart';
import '../../new_inspection/widgets/new_inspection_card.dart';
import '../../new_inspection/widgets/record_audio_widget.dart';
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
                  GetBuilder<DetailsInspectionController>(
                    builder: (controller) {
                      return ListTile(
                        title: const Text('Tipo de Instalação'),
                        trailing: const Icon(Icons.arrow_drop_down),
                        subtitle: Text(
                          controller.arguments.inspection.name,
                          textScaleFactor: 1.1,
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible:
                        controller.arguments.inspection.description != null,
                    child: ListTile(
                      title: const Text('Instalação'),
                      trailing: const Icon(Icons.arrow_drop_down),
                      subtitle: Text(
                        controller.arguments.inspection.installationId
                            .toString(),
                        textScaleFactor: 1.1,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller
                                .arguments.inspection.equipmentCategoryId !=
                            null &&
                        (controller.arguments.inspection.equipmentCategoryId ==
                                5 ||
                            controller.arguments.inspection.installationId ==
                                4 ||
                            controller
                                    .arguments.inspection.equipmentCategoryId ==
                                1),
                    child: ListTile(
                      title: const Text('Torre'),
                      trailing: const Icon(Icons.arrow_drop_down),
                      subtitle: Text(
                        controller.arguments.inspection.towerName ?? '',
                        textScaleFactor: 1.1,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (controller
                                .arguments.inspection.equipmentCategoryId ==
                            3 ||
                        controller.arguments.inspection.installationId == 2),
                    child: ListTile(
                      title: const Text('Categoria do equipamento'),
                      trailing: const Icon(Icons.arrow_drop_down),
                      subtitle: Text(
                        controller.arguments.inspection.equipmentName,
                        textScaleFactor: 1.1,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (controller
                                .arguments.inspection.equipmentCategoryId ==
                            3 ||
                        controller.arguments.inspection.installationId == 2),
                    child: ListTile(
                      title: const Text('Nível de tensão'),
                      trailing: const Icon(Icons.arrow_drop_down),
                      subtitle: Text(
                        controller.arguments.inspection.towerName ?? '',
                        textScaleFactor: 1.1,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.arguments.inspection.tensionLevelId !=
                            null &&
                        (controller.arguments.inspection.equipmentCategoryId ==
                                3 ||
                            controller.arguments.inspection.installationId ==
                                2),
                    child: ListTile(
                      title: const Text('Equipamento'),
                      trailing: const Icon(Icons.arrow_drop_down),
                      subtitle: Text(
                        controller.arguments.inspection.equipmentName,
                        textScaleFactor: 1.1,
                      ),
                    ),
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
            //const LocationNewInspectionWidget(),
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
