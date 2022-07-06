import 'package:fisplan_alupar/app/core/app_validators.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/images_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/question_widget.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/tower_widget.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/view_image_widget.dart';
import 'package:fisplan_alupar/app/shared/widgets/button_default_widget.dart';
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
            const TitleWidget(),
            const SizedBox(height: 10),
            Text(
              Get.find<NewInspectionController>().arguments.project.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const FiltersWidget(),
            const SizedBox(height: 10),
            GetBuilder<NewInspectionController>(
              builder: (control) {
                return Visibility(
                  visible: control.showQuestionnaries,
                  replacement: const SizedBox.shrink(),
                  child: NewInspectionCard(
                    title: 'Perguntas',
                    child: Column(
                      children: control.questions.map(
                        (question) {
                          return QuestionWidget(question);
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const PhotosWidget(),
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
              title: 'Comentários',
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormWidget(
                  hintText: 'Informações adicionais',
                  maxLines: 3,
                ),
              ),
            ),
            const SizedBox(height: 40),
            GetBuilder<NewInspectionController>(
              builder: (control) {
                return ButtonDefaultWidget(
                  title: control.arguments.inspectionRequest != null &&
                          control.arguments.isItDuplication == false
                      ? "Salvar Alteração"
                      : "Salvar",
                  onTap: control.verify,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
