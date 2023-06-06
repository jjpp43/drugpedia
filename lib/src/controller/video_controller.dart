import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends StatelessWidget {
  final String videoId;

  const VideoController({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      progressColors: ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.red.withOpacity(0.9),
      ),
      onReady: () {},
    );
  }
}
