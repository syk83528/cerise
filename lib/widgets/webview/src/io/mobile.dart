import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobileWebView extends StatefulWidget {
  const MobileWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  _MobileWebViewState createState() => _MobileWebViewState();
}

class _MobileWebViewState extends State<MobileWebView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      userAgent: Platform.isAndroid
          ? 'Mozilla/5.0 (Linux; Android 11; CPH2067) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Mobile Safari/537.36'
          : 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/19B81 [FBAN/FBIOS;FBDV/iPhone13,4;FBMD/iPhone;FBSN/iOS;FBSV/15.1.1;FBSS/3;FBID/phone;FBLC/en_US;FBOP/5]',
    );
  }
}
