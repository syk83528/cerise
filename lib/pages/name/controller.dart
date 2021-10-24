import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/tools/git/git.dart';

class NameController extends GetxController {
  final names = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    final people = await Git.browseLibrary();
    if (people == null) {
      final snackBar = SnackBar(content: Text('获取失败'));
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      return;
    }
    for (String? v in people) {
      if (v != null) {
        names.add(v);
      }
    }
  }
}
