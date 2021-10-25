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
  late final VideoPlayerController _controller;
  bool _playing = false;
  bool _fullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video)
      ..setLooping(true)
      ..initialize().then(
        (_) => setState(
          () {
            _playing = true;
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
        ? RotatedBox(
            quarterTurns: _fullScreen ? 1 : 0,
            child: InkWell(
              child: VideoPlayer(_controller),
              onTap: () async {
                if (_playing) {
                  await _controller.pause();
                } else {
                  await _controller.play();
                }
                setState(() {
                  _playing = !_playing;
                });
              },
              onLongPress: () {
                setState(() {
                  _fullScreen = !_fullScreen;
                });
              },
            ),
          )
        : Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
