import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  primary: _controller.isGitHub.value ? Colors.black : Colors.red[300],
                ),
                onPressed: _controller.switchRegistry,
                child: Text(
                  _controller.isGitHub.value ? 'GitHub' : 'JSDelivr',
                  style: TextStyle(
                    fontSize: 16,
                    color: _controller.isGitHub.value ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
