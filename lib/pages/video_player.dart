import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../theme.dart';

class WorkoutVideoPlayer extends StatefulWidget {
  const WorkoutVideoPlayer({Key? key, required this.videoURL})
      : super(key: key);
  final String videoURL;
  @override
  State<WorkoutVideoPlayer> createState() => _WorkoutVideoPlayerState();
}

class _WorkoutVideoPlayerState extends State<WorkoutVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoURL)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: AppColors.cardDark,
          body: Stack(fit: StackFit.expand, children: <Widget>[
            Container(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 8),
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: AppColors.cardLight.withOpacity(0.1),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: AppColors.cardLight.withOpacity(0.1),
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Log Workout Coming Soon'),
                            content: const Text(''),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('Exit'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: AppColors.cardLight.withOpacity(0.2),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
