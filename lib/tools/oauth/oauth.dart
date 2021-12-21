import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';

export 'enum.dart';

class OAuth {
  static Future<oauth2.Client?> login() async {
    final grant = oauth2.AuthorizationCodeGrant(
      '',
      Uri.parse('https://github.com/login/oauth/authorize?scope=repo,user'),
      Uri.parse('https://github.com/login/oauth/access_token'),
      secret: '',
      getParameters: (dynamic contentType, String body) {
        final value = Uri.decodeQueryComponent(body);
        final Map<String, dynamic> data = {};
        for (var item in value.split('&')) {
          final temp = item.split('=');
          data[temp[0]] = temp[1];
        }

        return data;
      },
    );
    final authorizationUrl = grant
        .getAuthorizationUrl(Uri.parse('https://ggdream.github.io/callback'));
    final responseUrl = await _getResponseUrl(
      authorizationUrl.toString(),
      'https://ggdream.github.io/callback',
    );
    if (responseUrl == null) return null;

    return await grant.handleAuthorizationResponse(
      Uri.parse(responseUrl).queryParameters,
    );
  }

  static Future<String?> _getResponseUrl(
    String authorizationUrl,
    String redirectUrl,
  ) async {
    if (kIsWeb) {
    } else if (GetPlatform.isMobile) {
      return await Get.to(
        () => AuthorizePage(
          authorizationUrl: authorizationUrl,
          redirectUrl: redirectUrl,
        ),
      );
    }
  }
}

class AuthorizePage extends StatelessWidget {
  const AuthorizePage({
    Key? key,
    required this.authorizationUrl,
    required this.redirectUrl,
  }) : super(key: key);

  final String authorizationUrl;
  final String redirectUrl;

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) WebView.platform = AndroidWebView();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: authorizationUrl,
          navigationDelegate: (NavigationRequest nr) async {
            if (nr.url.startsWith(redirectUrl)) {
              Navigator.of(context).pop(nr.url);
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
