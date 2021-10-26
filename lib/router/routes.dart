import 'package:get/get.dart';

import 'package:cerise/pages/entry/entry.dart';
import 'package:cerise/pages/home/home.dart';
import 'package:cerise/pages/image/image.dart';
import 'package:cerise/pages/type/type.dart';
import 'package:cerise/pages/verify/verify.dart';
import 'package:cerise/pages/video/video.dart';

import 'namespace.dart';

final List<GetPage> routes = [
  GetPage(name: RoutesNamespace.home, page: () => HomePage()),
  GetPage(name: RoutesNamespace.verify, page: () => VerifyPage()),
  GetPage(name: RoutesNamespace.entry, page: () => EntryPage()),
  GetPage(name: RoutesNamespace.image, page: () => ImagePage()),
  GetPage(name: RoutesNamespace.video, page: () => VideoPage()),
  GetPage(name: RoutesNamespace.type, page: () => TypePage()),
];
