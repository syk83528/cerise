import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/tools/oauth/oauth.dart';

import 'login_controller.dart';

class LoginBottomView extends StatelessWidget {
  const LoginBottomView({Key? key}) : super(key: key);

  static const List<String> _assets = [
    'assets/icons/google.png',
    'assets/icons/instagram.png',
    'assets/icons/github.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 40),
                Text(
                  '选择登录方式',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xffeaeaea),
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _assets.length,
                (index) {
                  return GestureDetector(
                    child: IconCard(asset: _assets[index]),
                    onTap: () => Get.back(result: OAuthEnum.values[index]),
                  );
                },
              ),
            ),
          ),
          protoView(),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget protoView() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Color(0xff5b92e2)),
        children: [
          agreeView(),
          WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: '我已阅读并同意',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: '《用户协议》',
            recognizer: TapGestureRecognizer()
              ..onTap = LoginController.to.toTermsPage,
          ),
          TextSpan(
            text: '《隐私政策》',
            recognizer: TapGestureRecognizer()
              ..onTap = LoginController.to.toPrivacyPage,
          ),
          TextSpan(
            text: '《社区规范》',
            recognizer: TapGestureRecognizer()
              ..onTap = LoginController.to.toRulesPage,
          ),
        ],
      ),
    );
  }

  WidgetSpan agreeView() {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Obx(() {
        final hasRead = LoginController.to.hasReadProtocol.value;
        return GestureDetector(
          onTap: () => LoginController.to.hasReadProtocol.toggle(),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: hasRead ? Colors.black : null,
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: hasRead
                ? Icon(
                    CupertinoIcons.check_mark,
                    color: Colors.white,
                    size: 8,
                  )
                : null,
          ),
        );
      }),
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffeaeaea)),
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: Image.asset(asset, width: 24),
    );
  }
}
