import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/styles/styles.dart';
import 'package:cerise/widgets/button/button.dart';
import 'package:cerise/widgets/empty/empty.dart';

import 'player/video_player.dart';
import 'player/video_player_desktop.dart'
    if (dart.library.html) 'player/video_player_web.dart';

import 'controller.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key? key}) : super(key: key);

  final _controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: _controller.urls.isEmpty ? Colors.white : Colors.black,
        body: Stack(
          children: [
            _videoView(),
            _opsView(),
          ],
        ),
      ),
    );
  }

  Widget _opsView() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Obx(() {
          return Row(
            children: [
              BackBtn(
                color: _controller.urls.isEmpty ? Colors.black : Colors.white,
              ),
              Spacer(),
              _controller.urls.isEmpty ? SizedBox() : _moreOpsView(),
            ],
          );
        }),
      ),
    );
  }

  Widget _moreOpsView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _controller.replaceVideo,
          icon: Icon(
            CupertinoIcons.square_list_fill,
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
        IconButton(
          onPressed: _controller.openBrowserVideo,
          icon: Icon(
            Icons.open_in_browser_rounded,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: _controller.selectAndupload,
          icon: Icon(
            Icons.cloud_upload_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _videoView() {
    return Obx(() {
      if (_controller.urls.isEmpty) {
        return Center(child: EmptyWidget());
      }

      return PageView.builder(
        physics: ScrollX.physics,
        scrollDirection: Axis.vertical,
        onPageChanged: _controller.onPage,
        controller: _controller.pageController,
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
      );
    });
  }
}
