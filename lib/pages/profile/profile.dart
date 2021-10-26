import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userInfoView(),
            _settingsView(),
          ],
        ),
      ),
    );
  }

  Widget _settingsView() {
    return Obx(
      () => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          primary: _controller.isGitHub.value ? Colors.black : Colors.red[300],
        ),
        onPressed: _controller.switchRegistry,
        icon: Icon(
          CupertinoIcons.arrow_2_circlepath_circle_fill,
          color: Colors.white,
        ),
        label: Text(
          _controller.isGitHub.value ? 'GitHub' : 'JSDelivr',
          style: TextStyle(
            color: _controller.isGitHub.value ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _userInfoView() {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              _controller.avatar.value,
              width: 128,
              height: 128,
              errorBuilder: (a, b, c) {
                return SizedBox();
              },
            ),
          ),
          SizedBox(height: 16),
          Text(
            _controller.username.value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
