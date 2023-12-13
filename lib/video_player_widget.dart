import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:videomanipulator/providers/list_videos_provider.dart';
import 'package:videomanipulator/providers/progress_provider.dart';

import 'package:path/path.dart' as p;
import 'package:videomanipulator/utils/path_utils.dart';
class VideoPlayerWidget extends StatefulWidget {
  final bool isPlayed;
  final FileSystemEntity video;

  const VideoPlayerWidget({
    super.key,
    required this.video,
    required this.isPlayed
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  late VideoPlayerController controller;

  late Future<void> futureController;

  bool widgetIsPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetIsPlaying = true;
    initialize(widget.video);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    widgetIsPlaying = false;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureController,
        builder: (_,snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.isPlayed?
                            Text(
                              PathUtils().getNameByPath(widget.video.path),
                              style: const TextStyle(color: Colors.white),
                            ) : const Text(""),

                            SizedBox(
                              width: 600,
                              height: 300,
                              child: AspectRatio(
                                  aspectRatio: controller.value.aspectRatio,
                                  child: VideoPlayer(controller)
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }


  initialize(FileSystemEntity video) {
    final file = File(video.path);
    controller = VideoPlayerController.file(file);
    futureController = controller.initialize().then((_) {
      controller.play();
      controller.setLooping(true);
      controller.setVolume(1.0);
    });

  }
}
