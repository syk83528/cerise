import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/tools/browser/browser.dart';
import 'package:cerise/tools/git/git.dart';

import 'world_model.dart';

class WorldController extends GetxController {
  final items = <WorldItemModel>[].obs;
  final page = 0.obs;

  final ScrollController scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    await _load();

    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (_isLoading) return;

        _isLoading = true;
        _load().whenComplete(() => _isLoading = false);
      }
    });
  }

  Future<void> _load() async {
    final res = await Git.getComments(page: page.value + 1, number: 20);
    final List<WorldItemModel> tempItems = [];

    for (var item in res) {
      late final List<String> values;

      try {
        values = (item['message'] as String).split('\n------\n');
        if (values.length != 2) continue;
      } catch (e) {
        continue;
      }

      final temp = WorldItemModel(
        username: item['username'] ?? 'Unknown',
        avatar: item['avatar'],
        timestamp: item['datetime'],
        url: values.elementAt(1),
        message: values.elementAt(0),
      );
      tempItems.add(temp);
    }

    page.value += 1;
    items.addAll(tempItems);
  }

  Future<void> onPressItem(int index) async {
    final item = items[index];

    if (GetPlatform.isDesktop) {
      final config = CreateConfiguration(title: item.username);
      final webview = await WebviewWindow.create(configuration: config);
      webview.launch(item.url);
    } else {
      await Browser.launchUrl(item.url);
    }
  }
}
