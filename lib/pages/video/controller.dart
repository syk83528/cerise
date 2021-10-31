import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cerise/styles/styles.dart';
import 'package:cerise/tools/browser/browser.dart';
import 'package:cerise/tools/git/git.dart';
import 'package:cerise/tools/selector/selector.dart';
import 'package:cerise/tools/screen/screen.dart';
import 'package:cerise/tools/shares/shares.dart';
import 'package:cerise/widgets/loading/loading.dart';

import 'widget.dart';

class VideoController extends GetxController {
  final name = ''.obs;
  final urls = <String>[].obs;
  final index = 0.obs;

  final PageController pageController = PageController();

  static VideoController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  @override
  void onClose() {
    Screen.unlock();
    super.onClose();
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

      if (urls.isNotEmpty) {
        snackBar = SnackBar(content: Text('获取视频成功: 共${urls.length}个'));
      }
    } catch (e) {
      snackBar = SnackBar(content: Text(e.toString()));
    } finally {
      await Loading.close();
      if (urls.isNotEmpty) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        await Screen.lock();
      }
    }
  }

  void onPage(int page) {
    index.value = page;
  }

  Future<void> replaceVideo() async {
    final result = await showDialog(
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * .1,
            vertical: Get.height * .1,
          ),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              child: ListView.builder(
                physics: ScrollX.physics,
                itemCount: urls.length,
                itemBuilder: (context, idx) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          index.value.isEqual(idx) ? Colors.black : null,
                      child: Text(
                        (idx + 1).toString(),
                        style: TextStyle(
                          color: index.value.isEqual(idx) ? Colors.white : null,
                        ),
                      ),
                    ),
                    title: Text(Uri.decodeComponent(urls[idx].split('/').last)),
                    onTap: () => Get.back(result: idx),
                  );
                },
              ),
            ),
          ),
        );
      },
    );

    if (result == null) return;
    pageController.jumpToPage(result);
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

    final videos = await _selectVideo();
    if (videos.isEmpty) return;

    final msg = await showDialog<String>(
      context: Get.context!,
      builder: (context) => AlertDialogInputView(),
    );
    if (msg == null) return;

    try {
      Loading.show('上传中');

      for (var video in videos) {
        final data = await video.readAsBytes();
        final gitpath = 'library/${name.value}/video/${video.name}';
        await Git.createFile(gitpath: gitpath, data: data, message: msg);
      }

      if (!(Git.isPrivate)) {
        await Git.createComment(msg);
      }

      snackBar = SnackBar(content: Text('上传完成'));
    } on UnimplementedError {
      snackBar = SnackBar(content: Text('该平台暂时无法上传视频'));
    } catch (e) {
      snackBar = SnackBar(content: Text(e.toString()));
    } finally {
      await Loading.close();
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<List<XFile>> _selectVideo() async {
    return await FileSelector.pickVideos();
  }
}
