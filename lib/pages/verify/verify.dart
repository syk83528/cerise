import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/widgets/captcha/captcha.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Captcha(
          answer: const [4, 3, 5, 2, 8],
          onResult: (result) {
            if (result) {
              Get.offNamed(RoutesNamespace.entry);
            } else {
              exit(0);
            }
          },
        ),
      ),
    );
  }
}
