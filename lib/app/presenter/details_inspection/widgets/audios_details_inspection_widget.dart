import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/controllers/audios_controller.dart';
import '../../new_inspection/widgets/new_inspection_card.dart';

class AudiosDetailsInspectionWidget extends StatelessWidget {
  const AudiosDetailsInspectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewInspectionCard(
      title: 'Áudios',
      child: GetBuilder<AudiosController>(
        builder: (control) {
          return Column(
            children: control.audiosOfWeb.map(
              (a) {
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
                              max: a.player.duration?.inSeconds.toDouble() ??
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
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
