// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show window;

Future<void> openIt(String url, [String title = '']) async {
  window.open(url, '_blank');
}
