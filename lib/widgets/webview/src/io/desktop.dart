import 'package:desktop_webview_window/desktop_webview_window.dart';

Future<void> openIt(String url, [String title = '']) async {
  final config = CreateConfiguration(title: title);
  final webview = await WebviewWindow.create(configuration: config);
  webview.launch(url);
}
