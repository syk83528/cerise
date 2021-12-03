import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:cerise/tools/toast/toast.dart';

class CodeController extends GetxController {
  Future<void> shareCode(Widget widget) async {
    final path = (await getTemporaryDirectory()).path;

    try {
      final data = await ScreenshotController().captureFromWidget(
        widget,
        pixelRatio: window.devicePixelRatio,
      );

      final imageFile = await File('$path/qrcode.png').create();
      await imageFile.writeAsBytes(data, flush: true);
      await Share.shareFiles([path], subject: '二维码分享', text: '魔咔啦咔的二维码');
    } on UnimplementedError {
      Toast.showText('该平台暂时无法分享文件，文件已保存至：$path/qrcode.png');
    } catch (e) {
      Toast.showText('分享失败，原因是：${e.toString()}');
    }
  }
}
