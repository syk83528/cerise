import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> configureApp() async {
  setUrlStrategy(PathUrlStrategy());
}

Future<void> configureAppLate() async {}
