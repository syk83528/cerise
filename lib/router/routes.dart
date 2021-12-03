import 'package:get/get.dart';

import 'package:cerise/pages/browser/browser.dart';
import 'package:cerise/pages/copywrite/copywrite.dart';
import 'package:cerise/pages/entry/entry.dart';
import 'package:cerise/pages/home/home.dart';
import 'package:cerise/pages/image/image.dart';
import 'package:cerise/pages/login/login.dart';
import 'package:cerise/pages/night/night.dart';
import 'package:cerise/pages/profile/profile.dart';
import 'package:cerise/pages/setting/setting.dart';
import 'package:cerise/pages/spider/spider.dart';
import 'package:cerise/pages/splash/splash.dart';
import 'package:cerise/pages/tool/tool.dart';
import 'package:cerise/pages/type/type.dart';
import 'package:cerise/pages/verify/verify.dart';
import 'package:cerise/pages/video/video.dart';

import 'namespace.dart';

final List<GetPage> routes = [
  GetPage(name: RoutesNamespace.splash, page: () => SplashPage()),
  GetPage(name: RoutesNamespace.home, page: () => HomePage()),
  GetPage(name: RoutesNamespace.verify, page: () => VerifyPage()),
  GetPage(name: RoutesNamespace.entry, page: () => EntryPage()),
  GetPage(name: RoutesNamespace.image, page: () => ImagePage()),
  GetPage(name: RoutesNamespace.video, page: () => VideoPage()),
  GetPage(name: RoutesNamespace.type, page: () => TypePage()),
  GetPage(name: RoutesNamespace.night, page: () => NightPage()),
  GetPage(name: RoutesNamespace.copywrite, page: () => CopywritingPage()),
  GetPage(name: RoutesNamespace.spider, page: () => SpiderPage()),
  GetPage(name: RoutesNamespace.tool, page: () => ToolPage()),
  GetPage(name: RoutesNamespace.browser, page: () => BrowserPage()),
  GetPage(name: RoutesNamespace.profile, page: () => ProfilePage()),
  GetPage(name: RoutesNamespace.setting, page: () => SettingPage()),
  GetPage(name: RoutesNamespace.login, page: () => LoginPage()),
];
