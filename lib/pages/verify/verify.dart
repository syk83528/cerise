import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/tools/git/git.dart';
import 'package:cerise/widgets/captcha/captcha.dart';
import 'package:cerise/widgets/loading/loading.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Captcha(
          answer: const [4, 3, 5, 2, 8],
          onResult: (result) async {
            if (!result) return;

            try {
              Loading.show('请求中');
              await Git.init();
            } catch (e) {
              final snackBar = SnackBar(content: Text(e.toString()));
              ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
              Get.offAllNamed(RoutesNamespace.entry);
              return;
            } finally {
              await Loading.close();
            }

            Get.offAllNamed(RoutesNamespace.home);
          },
        ),
      ),
    );
  }
}
