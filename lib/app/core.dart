import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/styles/styles.dart';
import 'package:cerise/tools/meta/meta.dart';

import 'preview.dart';

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: _CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      enableLog: !kReleaseMode,
      builder: EasyLoading.init(builder: Preview.builder),
      locale: Preview.locale(context),
      getPages: RouterX.routes,
      initialRoute: RouterX.initRoute,
      theme: ThemeX.global,
      title: Meta.name,
      defaultTransition: Transition.cupertino,
    );
  }
}

class _CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
