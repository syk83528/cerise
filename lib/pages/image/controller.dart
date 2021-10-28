import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cerise/tools/browser/browser.dart';
import 'package:cerise/tools/git/git.dart';
import 'package:cerise/tools/shares/shares.dart';
import 'package:cerise/widgets/loading/loading.dart';

class ImageController extends GetxController {
  final name = ''.obs;
  final images = <String>[].obs;

  static ImageController get to => Get.find();

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
      final result = await Git.browserImages(tName);
      if (result == null) {
        final snackBar = SnackBar(content: Text('获取失败'));
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      } else {
        for (String? element in result) {
          if (element != null) {
            images.add(element);
          }
        }
      }

      if (images.isNotEmpty) {
        snackBar = SnackBar(content: Text('获取图片成功: 共${images.length}张'));
      }
    } catch (e) {
      snackBar = SnackBar(content: Text(e.toString()));
    } finally {
      await Loading.close();
      if (images.isNotEmpty) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    }
  }

  Future<void> moreOps(String url) async {
    await _showOpsBottom(url);
  }

  Future<void> _openBrowserImage(String url) async {
    await Browser.launchUrl(url);
  }

  Future<void> _shareImage(String url) async {
    final text = '来自Cerise分享的图片：$url。快去打开查看叭！🔥🔥';
    await Shares.share(text);
  }

  Future<void> _copyLink(String url) async {
    final data = ClipboardData(text: url);
    await Clipboard.setData(data);
  }

  Future<void> _showOpsBottom(String url) async {
    return await showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
              top: 16,
              bottom: 48,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 40,
                  color: Colors.black,
                  tooltip: '在浏览器打开',
                  onPressed: () => _openBrowserImage(url),
                  icon: Icon(
                    CupertinoIcons.tv_circle_fill,
                    size: 40,
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  color: Colors.black,
                  tooltip: '分享图片',
                  onPressed: () => _shareImage(url),
                  icon: Icon(CupertinoIcons.arrow_up_right_circle_fill),
                ),
                IconButton(
                  iconSize: 40,
                  color: Colors.black,
                  tooltip: '复制链接',
                  onPressed: () => _copyLink(url),
                  icon: Icon(CupertinoIcons.link_circle_fill),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> selectAndupload() async {
    late final SnackBar snackBar;

    try {
      final image = await _selectImage();
      if (image == null) return;

      Loading.show('上传中');
      final data = await image.readAsBytes();
      final gitpath = 'library/${name.value}/image/${image.name}';
      await Git.createFile(gitpath: gitpath, data: data);
      snackBar = SnackBar(content: Text('上传成功: ${image.name}'));
    } catch (e) {
      snackBar = SnackBar(content: Text(e.toString()));
    } finally {
      await Loading.close();
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<XFile?> _selectImage() async {
    if (GetPlatform.isDesktop) {
      throw UnimplementedError('Upload images');
    }

    final picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }
}
