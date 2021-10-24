import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  Permissions._();

  static bool get _isMobile => GetPlatform.isMobile;

  static final List<Permission> _requestList = [
    Permission.storage,
    Permission.camera,
    Permission.photos,
    Permission.mediaLibrary,
    Permission.location,
    Permission.speech,
  ];

  static Future<void> request() async {
    if (!_isMobile) return;

    await _requestList.request();
  }
}
