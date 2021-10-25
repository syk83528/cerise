import 'dart:math';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

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
  late final Player _player;
  bool _fullScreen = false;

  @override
  void initState() {
    super.initState();

    final media = Media.network(widget.video);
    _player = Player(id: Random().nextInt(65536))
      ..setPlaylistMode(PlaylistMode.repeat)
      ..open(media, autoStart: true);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: _fullScreen ? 1 : 0,
      child: GestureDetector(
        onTap: () => _player.playOrPause(),
        onLongPress: () {
          setState(() {
            _fullScreen = !_fullScreen;
          });
        },
        child: Video(
          player: _player,
          showControls: false,
        ),
      ),
    );
  }
}
