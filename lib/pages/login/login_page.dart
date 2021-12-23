import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/widgets/swiper/swiper.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundView(),
          formView(),
        ],
      ),
    );
  }

  Widget formView() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 32,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          coreView(),
          SizedBox(height: 60),
          protoView(),
        ],
      ),
    );
  }

  Widget coreView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          phoneView(),
          SizedBox(height: 16),
          clickView(),
          SizedBox(height: 24),
          thirdView(),
          SizedBox(height: 24),
          otherView(),
        ],
      ),
    );
  }

  Widget protoView() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white.withOpacity(.7),
          fontSize: 12,
        ),
        children: [
          agreeView(),
          WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(text: '我已阅读并同意'),
          TextSpan(
            text: '《用户协议》',
            recognizer: TapGestureRecognizer()..onTap = _controller.toTermsPage,
          ),
          TextSpan(
            text: '《隐私政策》',
            recognizer: TapGestureRecognizer()
              ..onTap = _controller.toPrivacyPage,
          ),
          TextSpan(
            text: '《社区规范》',
            recognizer: TapGestureRecognizer()..onTap = _controller.toRulesPage,
          ),
        ],
      ),
    );
  }

  WidgetSpan agreeView() {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Obx(() {
        final hasRead = _controller.hasReadProtocol.value;
        return GestureDetector(
          onTap: () => _controller.hasReadProtocol.toggle(),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: hasRead ? Colors.white : null,
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: hasRead
                ? Icon(
                    CupertinoIcons.check_mark,
                    color: Colors.black,
                    size: 8,
                  )
                : null,
          ),
        );
      }),
    );
  }

  Widget otherView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        GestureDetector(
          onTap: _controller.otherLoginWays,
          child: Text(
            '其他登录方式',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 2),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 12,
        ),
      ],
    );
  }

  Widget thirdView() {
    return GestureDetector(
      onTap: _controller.loginWithGitHub,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.6),
          borderRadius: BorderRadius.circular(36),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/wechatop.png',
              width: 24,
            ),
            SizedBox(width: 4),
            Text('微信登录', style: _textStyle),
          ],
        ),
      ),
    );
  }

  /// 一键登录
  Widget clickView() {
    return GestureDetector(
      onTap: () => Get.offAllNamed(RoutesNamespace.entry),
      child: Container(
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          color: Color(0xffff2442),
          borderRadius: BorderRadius.circular(36),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('一键登录', style: _textStyle),
          ],
        ),
      ),
    );
  }

  Widget phoneView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '+86',
          style: _textStyle,
        ),
        SizedBox(width: 8),
        Text(
          '199 **** 4143',
          style: _textStyle,
        ),
      ],
    );
  }

  Widget backgroundView() {
    return SwiperView.asset(
      images: List.generate(6, (index) => 'assets/images/login/$index.webp'),
    );
  }

  final _textStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
}
