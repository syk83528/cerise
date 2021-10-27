import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/tools/git/git.dart';
import 'package:cerise/widgets/loading/loading.dart';

class StoreController extends GetxController {
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

  Future<void> createEntry() async {
    final result = await showDialog<String?>(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text(
            '名称',
            style: TextStyle(color: Colors.black),
          ),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text('确定'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('取消'),
            ),
          ],
        );
      },
    );

    if (result == null || result.isEmpty || names.contains(result)) return;

    late final SnackBar snackBar;
    try {
      Loading.show('创建中');
      await Git.createIVKeepFile(result);
      names.add(result);
      snackBar = SnackBar(content: Text('创建成功'));
    } catch (e) {
      snackBar = SnackBar(content: Text('创建失败: ${e.toString()}'));
    } finally {
      await Loading.close();
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }
}
