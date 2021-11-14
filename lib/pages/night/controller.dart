import 'package:get/get.dart';

import 'package:cerise/router/router.dart';

class NightController extends GetxController {
  final tabs = <_Model>[
    _Model(label: '文案制作', route: RoutesNamespace.copywrite),
    _Model(label: '爬虫制作', route: RoutesNamespace.spider),
  ];
}

class _Model {
  final String label;
  final String route;

  _Model({
    required this.label,
    required this.route,
  });
}
