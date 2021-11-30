import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/widgets/button/button.dart';

import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final _controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: bodyView(),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: BackBtn(),
      title: Text('应用设置'),
      centerTitle: true,
    );
  }

  Widget bodyView() {
    return Obx(() {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.store_rounded),
            title: Text('仓库源'),
            subtitle: Text(
              _controller.isGitHub.value ? 'GitHub' : 'JSDelivr',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: _controller.switchRegistry,
          ),
          ListTile(
            leading: Icon(Icons.visibility_rounded),
            title: Text('仓库可见性'),
            subtitle: Text(
              _controller.isPrivate.value ? '私有仓库' : '公开仓库',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: _controller.changeVisual,
          ),
        ],
      );
    });
  }
}
