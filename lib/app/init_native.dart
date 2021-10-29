import 'dart:io';

import 'package:cerise/config/config.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_size/window_size.dart';

Future<void> configureApp() async {
  if (GetPlatform.isDesktop) {
    DartVLC.initialize();
  }
}

Future<void> configureAppLate() async {
  if (GetPlatform.isDesktop) {
    await _initSystemTray();
  }
}

Future<void> _initSystemTray() async {
  final tray = SystemTray();

  final icon = joinAll([
    dirname(Platform.resolvedExecutable),
    'data/flutter_assets/assets/raw',
    Platform.isWindows ? 'logo.ico' : 'logo.png',
  ]);
  final menus = [
    MenuItem(
      label: '显示',
      onClicked: () {
        setWindowVisibility(visible: true);
        Config.isVisual = true;
      },
    ),
    MenuItem(
      label: '隐藏',
      onClicked: () {
        setWindowVisibility(visible: false);
        Config.isVisual = false;
      },
    ),
  ];
  await tray.initSystemTray('cerise', iconPath: icon);
  await tray.setContextMenu(menus);
  tray.registerSystemTrayEventHandler((event) {
    if (event == 'leftMouseUp') {
      setWindowVisibility(visible: !Config.isVisual);
      Config.isVisual = !Config.isVisual;
    }
  });
}
