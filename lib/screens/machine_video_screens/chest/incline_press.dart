import 'package:flutter/material.dart';
import 'package:the_bar_gym/pages/video_player.dart';

class InclinePressVideoPage extends StatelessWidget {
  const InclinePressVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkoutVideoPlayer(
        videoURL:
            'https://res.cloudinary.com/spacemuletech/video/upload/v1632419747/Pexels_Videos_1877846_fgryqb.mp4');
  }
}
