import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:cerise/styles/styles.dart';
import 'package:cerise/widgets/button/button.dart';

import 'code_controller.dart';

class QRCodePage extends StatelessWidget {
  QRCodePage({Key? key}) : super(key: key);

  final _controller = Get.put(CodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return Center(
      child: Container(
        width: 320,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: ColorsX.bluePurple,
          borderRadius: BorderRadius.circular(16),
        ),
        child: coreView(),
      ),
    );
  }

  Widget captureView() {
    return Card(
      child: Container(
        width: 320,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 12,
        ),
        color: ColorsX.bluePurple,
        child: coreView(),
      ),
    );
  }

  Widget coreView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: QrImage(
                padding: EdgeInsets.zero,
                data: 'gaa',
                size: 84,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.circle,
                  color: ColorsX.bluePurple,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: ColorsX.bluePurple,
                ),
                foregroundColor: ColorsX.bluePurple,
                version: 2,
              ),
            ),
          ],
        ),
        Divider(
          height: 0,
          thickness: .4,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 20),
              ClipOval(
                child: Image.asset(
                  'assets/images/login/5.webp',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '魔咔啦咔',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '樱桃号：979779',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: BackBtn(),
      title: Text('我的二维码'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _controller.shareCode(captureView()),
          icon: Image.asset('assets/icons/share.png'),
        ),
      ],
    );
  }
}
