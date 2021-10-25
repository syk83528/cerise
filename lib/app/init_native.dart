import 'package:dart_vlc/dart_vlc.dart';
import 'package:get/get.dart';

void configureApp() {
  if (GetPlatform.isDesktop) {
    DartVLC.initialize();
  }
}
