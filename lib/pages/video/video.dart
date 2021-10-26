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
      body: Stack(
        children: [
          _videoView(),
          _opsView(),
        ],
      ),
    );
  }

  Widget _opsView() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: _controller.selectAndupload,
              icon: Icon(
                Icons.cloud_upload_rounded,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: _controller.shareVideo,
              icon: Icon(
                Icons.share_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoView() {
    return Obx(
      () => PageView.builder(
        physics: ScrollX.physics,
        scrollDirection: Axis.vertical,
        onPageChanged: _controller.onPage,
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
    );
  }
}
