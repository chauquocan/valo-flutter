import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/full_video.dart';
import 'package:video_player/video_player.dart';

class WidgetVideoMessage extends StatefulWidget {
  final String videoUrl;
  const WidgetVideoMessage({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _WidgetVideoMessageState createState() => _WidgetVideoMessageState(videoUrl);
}

class _WidgetVideoMessageState extends State<WidgetVideoMessage> {
  final VideoPlayerController videoPlayerController;
  final String videoUrl;
  double videoDuration = 0;
  double currentDuration = 0;

  _WidgetVideoMessageState(this.videoUrl)
      : videoPlayerController = VideoPlayerController.network(videoUrl);

  @override
  void initState() {
    super.initState();
    videoPlayerController.initialize().then((_) {
      setState(() {
        videoDuration =
            videoPlayerController.value.duration.inMilliseconds.toDouble();
      });
    });

    videoPlayerController.addListener(() {
      setState(() {
        currentDuration =
            videoPlayerController.value.position.inMilliseconds.toDouble();
      });
    });
    print(videoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController.value.isInitialized
        ? Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    videoPlayerController.value.isPlaying
                        ? videoPlayerController.pause()
                        : videoPlayerController.play();
                  });
                },
                onDoubleTap: () => {
                  videoPlayerController.pause(),
                  Get.to(() => FullVideoScreen(videoUrl: videoUrl))
                },
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController),
                ),
              ),
              Container(
                color: Colors.black,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: IconButton(
                          icon: Icon(
                            videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              videoPlayerController.value.isPlaying
                                  ? videoPlayerController.pause()
                                  : videoPlayerController.play();
                            });
                          }),
                    ),
                    Expanded(
                      child: Slider(
                        value: currentDuration,
                        max: videoDuration,
                        inactiveColor: Colors.white,
                        onChanged: (value) => videoPlayerController
                            .seekTo(Duration(milliseconds: value.toInt())),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container(
            height: 200, child: Center(child: CircularProgressIndicator()));
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
