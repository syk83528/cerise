import 'package:get/get.dart';

import 'package:cerise/pages/entry/entry.dart';
import 'package:cerise/pages/home/home.dart';
import 'package:cerise/pages/image/image.dart';
import 'package:cerise/pages/verify/verify.dart';

import 'namespace.dart';

final List<GetPage> routes = [
  GetPage(name: RoutesNamespace.home, page: () => HomePage()),
  GetPage(name: RoutesNamespace.verify, page: () => VerifyPage()),
  GetPage(name: RoutesNamespace.entry, page: () => EntryPage()),
  GetPage(name: RoutesNamespace.image, page: () => ImagePage()),
];
