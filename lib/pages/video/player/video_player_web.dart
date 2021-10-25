import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerOther extends StatefulWidget {
  const VideoPlayerOther({
    Key? key,
    required this.video,
  }) : super(key: key);

  final String video;

  @override
  _VideoPlayerOtherState createState() => _VideoPlayerOtherState();
}

class _VideoPlayerOtherState extends State<VideoPlayerOther> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video)
      ..setLooping(true)
      ..initialize().then(
        (_) => setState(
          () {
            _controller.play();
          },
        ),
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : Center(child: Text('Loading...'));
  }
}
