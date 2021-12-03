import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';

import 'package:cerise/styles/styles.dart';
import 'package:cerise/widgets/button/button.dart';

import 'scan_controller.dart';

class ScanPage extends StatelessWidget {
  ScanPage({Key? key}) : super(key: key);

  final _controller = Get.put(ScanerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return Stack(
      children: [
        GetPlatform.isMobile
            ? GestureDetector(
                onDoubleTap: _controller.controlLight,
                child: ScanView(
                  controller: _controller.scanController,
                  onCapture: _controller.onCapture,
                  scanLineColor: Colors.white,
                ),
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    '该平台目前不支持扫描二维码',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconCardBtn(
                asset: 'assets/images/scan/qrcode.png',
                label: '我的二维码',
                onClick: _controller.getMyQRCode,
              ),
              IconCardBtn(
                asset: 'assets/images/scan/photo.png',
                label: '相册',
                onClick: _controller.pickImageAndScan,
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: GetPlatform.isMobile ? Colors.transparent : Colors.black,
      elevation: 0,
      shadowColor: ColorsX.greyLight,
      leading: BackBtn(color: Colors.white),
      title: Text(
        '扫描二维码',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}

class IconCardBtn extends StatelessWidget {
  const IconCardBtn({
    Key? key,
    required this.asset,
    required this.label,
    this.onClick,
  }) : super(key: key);

  final String asset;
  final String label;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            asset,
            width: 64,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
