import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/styles/styles.dart';

import 'player/video_player.dart';
import 'player/video_player_desktop.dart'
    if (dart.library.html) 'player/video_player_web.dart';

import 'controller.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key? key}) : super(key: key);

  final _controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => PageView.builder(
          physics: ScrollX.physics,
          scrollDirection: Axis.vertical,
          itemCount: _controller.urls.length,
          itemBuilder: (context, index) {
            if (GetPlatform.isMobile) {
              return VideoPlayer(
                video: _controller.urls[index],
              );
            } else if (GetPlatform.isWeb || GetPlatform.isDesktop) {
              return VideoPlayerOther(
                video: _controller.urls[index],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
