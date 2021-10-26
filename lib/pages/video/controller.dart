import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cerise/tools/browser/browser.dart';
import 'package:cerise/tools/git/git.dart';
import 'package:cerise/tools/shares/shares.dart';
import 'package:cerise/widgets/loading/loading.dart';

class VideoController extends GetxController {
  final name = ''.obs;
  final urls = <String>[].obs;
  final index = 0.obs;

  static VideoController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    final tName = Get.parameters['name'];
    if (tName == null) return;

    late final SnackBar snackBar;
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
      snackBar = SnackBar(content: Text('获取视频成功: 共${urls.length}个'));
    } catch (e) {
      snackBar = SnackBar(content: Text(e.toString()));
    } finally {
      await Loading.close();
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  void onPage(int page) {
    index.value = page;
  }

  Future<void> shareVideo() async {
    final url = urls.elementAt(index.value);
    final text = '来自Cerise分享的视频：$url。快去打开查看叭！🔥🔥';
    await Shares.share(text);
  }

  Future<void> openBrowserVideo() async {
    final url = urls.elementAt(index.value);
    await Browser.launchUrl(url);
  }

  Future<void> selectAndupload() async {
    late final SnackBar snackBar;

    try {
      final video = await _selectVideo();
      if (video == null) return;

      Loading.show('上传中');
      final data = await video.readAsBytes();
      final gitpath = 'library/${name.value}/video/${video.name}';
      await Git.createFile(gitpath: gitpath, data: data);
      snackBar = SnackBar(content: Text('上传成功: ${video.name}'));
    } catch (e) {
      snackBar = SnackBar(content: Text(e.toString()));
    } finally {
      await Loading.close();
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<XFile?> _selectVideo() async {
    if (GetPlatform.isDesktop) {
      throw UnimplementedError('Upload videos');
    }

    final picker = ImagePicker();
    return await picker.pickVideo(source: ImageSource.gallery);
  }
}
