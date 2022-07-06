import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/audios_controller.dart';
import 'new_inspection_card.dart';
import 'record_audio_widget.dart';

class AudiosWidget extends StatelessWidget {
  const AudiosWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewInspectionCard(
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
                            value: snapshot.data?.inSeconds.toDouble() ?? 0.0,
                            max: a.player.duration?.inSeconds.toDouble() ?? 0.0,
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
    );
  }
}