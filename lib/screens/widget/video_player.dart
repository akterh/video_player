import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class KVidePlayer extends StatefulWidget {
  const KVidePlayer({Key? key}) : super(key: key);

  @override
  State<KVidePlayer> createState() => _KVidePlayerState();
}

class _KVidePlayerState extends State<KVidePlayer> {
  VideoPlayerController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1/1,child: VideoPlayer(_controller!),);
  }
}
