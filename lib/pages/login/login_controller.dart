import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/tools/git/git.dart';
import 'package:cerise/tools/toast/toast.dart';
import 'package:cerise/tools/oauth/oauth.dart';
import 'package:cerise/widgets/loading/loading.dart';
import 'package:cerise/widgets/mdshower/mdshower.dart';

import 'login_widgets.dart';

class LoginController extends GetxController {
  final hasReadProtocol = false.obs;

  static LoginController get to => Get.find();

  Future<void> loginWithGitHub() async {
    final client = await OAuth.login();
    if (client == null) {
      Toast.showText('登陆失败');
      return;
    }

    final accessToken = client.credentials.accessToken;
    await _gotoNextPage(accessToken);
  }

  Future<void> _gotoNextPage(String accessToken) async {
    try {
      Loading.show('登陆中');
      final username = await Git.getUsernameByAT(accessToken);

      final Map<String, String> params = {
        'username': username!,
        'access_token': accessToken,
      };
      Get.offAllNamed(
        RoutesNamespace.entry,
        parameters: params,
      );
    } catch (e) {
      Toast.showText('登陆失败');
    } finally {
      await Loading.close();
    }
  }

  Future<void> otherLoginWays() async {
    final OAuthEnum? lEnum = await Get.bottomSheet<OAuthEnum>(
      LoginBottomView(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      backgroundColor: Colors.white,
    );
    if (lEnum == null) return;

    // debugPrint(lEnum.toString());
    // TODO: 走不同的登录逻辑
  }

  Future<void> toTermsPage() => _lookProtocol('用户协议', 'terms');

  Future<void> toPrivacyPage() => _lookProtocol('隐私政策', 'privacy');

  Future<void> toRulesPage() => _lookProtocol('社区规范', 'rules');

  Future<void> _lookProtocol(String title, String name) async {
    final data = await rootBundle.loadString('assets/data/text/$name.md');
    await Get.to(() => MDShowerPage(title: title, data: data));
  }
}
