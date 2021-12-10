import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullVideoScreen extends StatefulWidget {
  const FullVideoScreen({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  _FullVideoScreenState createState() => _FullVideoScreenState(videoUrl);
}

class _FullVideoScreenState extends State<FullVideoScreen> {
  final VideoPlayerController videoPlayerController;
  final String videoUrl;
  double videoDuration = 0;
  double currentDuration = 0;

  _FullVideoScreenState(this.videoUrl)
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
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => setAllorientations(), icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        // This line set the transparent background
        child: videoPlayerController.value.isInitialized
            ? Container(
                child: Center(
                  child: Column(
                    // alignment: AlignmentDirectional.bottomCenter,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              videoPlayerController.value.isPlaying
                                  ? videoPlayerController.pause()
                                  : videoPlayerController.play();
                            });
                          },
                          child: Container(
                              color: Colors.black,
                              // constraints: BoxConstraints(maxHeight: 800),
                              child: AspectRatio(
                                aspectRatio:
                                    videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(videoPlayerController),
                              )),
                        ),
                      ),
                      Row(
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
                              onChanged: (value) =>
                                  videoPlayerController.seekTo(
                                      Duration(milliseconds: value.toInt())),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: IconButton(
                                icon: Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                ),
                                onPressed: () => setLandScape()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Container(
                    height: 200,
                    child: Center(child: CircularProgressIndicator())),
              ),
      ),
    );
  }

  @override
  void dispose() {
    setAllorientations();
    videoPlayerController.dispose();
    super.dispose();
  }

  Future setAllorientations() async {
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  Future setLandScape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }
}
