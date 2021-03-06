import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,
    required this.video,
  }) : super(key: key);

  final String video;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();

    player.setLoop(0);
    player.setDataSource(widget.video, autoPlay: true);
  }

  @override
  void dispose() {
    player.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FijkView(
      color: Colors.black,
      player: player,
      panelBuilder: _panelBuilder,
    );
  }

  Widget _panelBuilder(
    FijkPlayer player,
    FijkData data,
    BuildContext context,
    Size viewSize,
    Rect texturePos,
  ) {
    return CustomFijkPanel(
      player: player,
      data: data,
      context: context,
      viewSize: viewSize,
      texturePos: texturePos,
    );
  }
}

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final FijkData data;
  final BuildContext context;
  final Size viewSize;
  final Rect texturePos;

  const CustomFijkPanel({
    Key? key,
    required this.player,
    required this.data,
    required this.context,
    required this.viewSize,
    required this.texturePos,
  }) : super(key: key);

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel> {
  FijkPlayer get player => widget.player;
  bool _playing = false;
  bool _fullScreen = false;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_onValueChanged);
  }

  void _onValueChanged() {
    FijkValue value = player.value;

    bool playing = (value.state == FijkState.started);
    if (playing != _playing) {
      setState(() {
        _playing = playing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: InkWell(
        child: SizedBox.expand(),
        onTap: () {
          _playing ? widget.player.pause() : widget.player.start();
        },
        onLongPress: () {
          if (_fullScreen) {
            widget.player.exitFullScreen();
          } else {
            widget.player.enterFullScreen();
          }
          setState(() {
            _fullScreen = !_fullScreen;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    player.removeListener(_onValueChanged);
    super.dispose();
  }
}
