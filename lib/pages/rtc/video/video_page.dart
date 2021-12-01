import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'video_controller.dart';

class VideoCallPage extends StatelessWidget {
  VideoCallPage({Key? key}) : super(key: key);

  final _controller = Get.put(VideoCallController());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
