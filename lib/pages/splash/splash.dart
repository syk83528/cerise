import 'package:flutter/material.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/tools/git/git.dart';
import 'package:cerise/widgets/splash/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashView(
      future: _future(),
      icon: 'assets/raw/logo.png',
      footer: '樱桃部落',
      // route: RoutesNamespace.home,
      route: RoutesNamespace.login,
      errRoute: RoutesNamespace.entry,
      color: Colors.white,
      backgroundColor: Colors.black,
    );
  }

  Future<void> _future() async {
    await Git.init();
  }
}
