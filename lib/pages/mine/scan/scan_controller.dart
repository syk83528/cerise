import 'package:get/get.dart';
import 'package:scan/scan.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/tools/selector/selector.dart';
import 'package:cerise/tools/toast/toast.dart';
import 'package:cerise/widgets/blank/blank.dart';
import 'package:cerise/widgets/webview/webview.dart';

class ScanerController extends GetxController {
  // final isLight = false.obs;
  final scanController = ScanController();

  Future<void> onCapture(String data) async {
    if (data.startsWith('http')) {
      await Get.to(MobileWebView(url: data));
    } else {
      await Get.to(BlankPage(title: '二维码内容', content: data));
    }

    scanController.resume();
  }

  Future<void> controlLight() async {
    scanController.toggleTorchMode();
  }

  Future<void> getMyQRCode() async {
    await Get.toNamed(RoutesNamespace.code);
  }

  Future<void> pickImageAndScan() async {
    if (!GetPlatform.isMobile) {
      Toast.showText('该平台目前不支持扫描二维码');
      return;
    }

    final file = await FileSelector.pickImages();
    if (file.isEmpty) return;

    final String? data = await Scan.parse(file[0].path);
    if (data == null) return;

    if (data.startsWith('http')) {
      await Get.to(MobileWebView(url: data));
    } else {
      await Get.to(BlankPage(title: '二维码内容', content: data));
    }

    scanController.resume();
  }
}
