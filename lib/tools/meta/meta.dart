import 'package:package_info_plus/package_info_plus.dart';

class Meta {
  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static late final PackageInfo _packageInfo;

  static String name = _packageInfo.appName;
  static String version = _packageInfo.version;
}
