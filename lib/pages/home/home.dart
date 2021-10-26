import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/pages/name/name.dart';
import 'package:cerise/pages/night/night.dart';
import 'package:cerise/pages/profile/profile.dart';
import 'package:cerise/pages/work/work.dart';

import 'controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: _controller.currentIndex.value,
          children: [
            WorkPage(),
            NamePage(),
            NightPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.camera_circle_fill),
              label: '仓库',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.moon_circle_fill),
              label: '夜晚',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_circle_fill),
              label: '档案',
            ),
          ],
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          currentIndex: _controller.currentIndex.value,
          onTap: _controller.onPage,
        ),
      ),
    );
  }
}
