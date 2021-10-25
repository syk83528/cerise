import 'package:cerise/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/tools/git/git.dart';

class VideoController extends GetxController {
  final name = ''.obs;
  final urls = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    final tName = Get.parameters['name'];
    if (tName == null) return;

    try {
      Loading.show('加载中');
      name.value = tName;
      final result = await Git.browserVideos(tName);
      if (result == null) {
        final snackBar = SnackBar(content: Text('获取失败'));
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      } else {
        for (String? element in result) {
          if (element != null) {
            urls.add(element);
          }
        }
      }
    } finally {
      await Loading.close();
    }
  }
}
