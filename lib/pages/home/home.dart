import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/pages/mine/mine.dart';
import 'package:cerise/pages/night/night.dart';
import 'package:cerise/pages/store/store.dart';
import 'package:cerise/pages/world/world.dart';

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
            WorldPage(),
            StorePage(),
            NightPage(),
            MinePage(),
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
