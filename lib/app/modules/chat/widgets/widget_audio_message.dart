import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

/// this widget is used to render voice note container
/// with ist full functionality
class AudioMessageWidget extends StatefulWidget {
  final String message;
  final Color senderColor;
  final Color inActiveAudioSliderColor;
  final Color activeAudioSliderColor;
  final bool isMe;
  final String dateTime;
  final String? avatar;

  const AudioMessageWidget({
    Key? key,
    required this.message,
    required this.dateTime,
    required this.senderColor,
    required this.isMe,
    required this.inActiveAudioSliderColor,
    required this.activeAudioSliderColor,
    this.avatar,
  }) : super(key: key);

  @override
  _AudioMessageWidgetState createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  final player = AudioPlayer();
  Duration? duration = Duration.zero;
  Duration seekBarposition = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    setData();
    super.initState();
  }

  void setData() async {
    widget.message != null
        ? duration = await player.setUrl(widget.message)
        : duration = await player.setFilePath(widget.message);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          widget.isMe
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        // top: 2,
                        left: 20 / 2,
                        right: 20 / 2,
                      ),
                      child: Text(
                        widget.dateTime,
                        style: TextStyle(
                            fontSize: 12,
                            color: Get.isDarkMode
                                ? Colors.white60
                                : Colors.black26),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10 * 0.75,
                          vertical: 10 / 2.5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.zero),
                          color: (widget.senderColor)
                              .withOpacity(widget.isMe ? 1 : 0.1),
                        ),
                        child: Row(
                          /// mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                isPlaying ? player.pause() : play();
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                // size: 25,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                  activeColor: Colors.white,
                                  inactiveColor:
                                      widget.inActiveAudioSliderColor,
                                  max: player.duration?.inMilliseconds
                                          .toDouble() ??
                                      1,
                                  value:
                                      player.position.inMilliseconds.toDouble(),
                                  onChanged: (d) {
                                    setState(() {
                                      player.seek(
                                          Duration(milliseconds: d.toInt()));
                                    });
                                  }),
                            ),
                            Text(
                              _printDuration(player.position),
                              style:
                                  const TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    WidgetAvatar(
                      url: widget.avatar,
                      isActive: false,
                      size: 45,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10 * 0.75,
                        vertical: 10 / 2.5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Get.isDarkMode
                            ? Colors.grey.shade200
                            : (widget.senderColor).withOpacity(0.1),
                      ),
                      child: Row(
                        /// mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              isPlaying ? player.pause() : play();
                              setState(() {
                                isPlaying = !isPlaying;
                              });
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : widget.senderColor,
                              // size: 25,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                                activeColor: Get.isDarkMode
                                    ? Colors.black
                                    : widget.activeAudioSliderColor,
                                inactiveColor: Get.isDarkMode
                                    ? Colors.black
                                    : widget.inActiveAudioSliderColor,
                                max: player.duration?.inMilliseconds
                                        .toDouble() ??
                                    1,
                                value:
                                    player.position.inMilliseconds.toDouble(),
                                onChanged: (d) {
                                  setState(() {
                                    player.seek(
                                        Duration(milliseconds: d.toInt()));
                                  });
                                }),
                          ),
                          Text(
                            _printDuration(player.position),
                            style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          // top: 2,
                          left: 20 / 2,
                          right: 20 / 2,
                        ),
                        child: Text(
                          widget.dateTime,
                          style: TextStyle(
                              fontSize: 12,
                              color: Get.isDarkMode
                                  ? Colors.white60
                                  : Colors.black26),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  /// this function is used to play audio wither its from url or path file
  void play() {
    if (player.duration != null && player.position >= player.duration!) {
      player.seek(Duration.zero);
      setState(() {
        isPlaying = false;
      });
    }
    player.play();

    player.positionStream.listen((duration) {
      // duration == player.duration;
      setState(() {
        seekBarposition = duration;
      });
      if (player.duration != null && player.position >= player.duration!) {
        player.stop();
        player.seek(Duration.zero);
        setState(() {
          isPlaying = false;
          seekBarposition = Duration.zero;
        });
      }
    });
  }

  /// function used to print the duration of the current audio duration
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String hoursString =
        duration.inHours == 0 ? '' : "${twoDigits(duration.inHours)}:";
    return "$hoursString$twoDigitMinutes:$twoDigitSeconds";
  }
}
