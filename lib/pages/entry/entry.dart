import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/tools/git/git.dart';
import 'package:cerise/widgets/loading/loading.dart';

class EntryPage extends StatelessWidget {
  EntryPage({Key? key}) : super(key: key);

  final _controller1 = TextEditingController(text: Get.parameters['username']);
  final _controller2 = TextEditingController(
    text: Get.parameters['access_token'] == null ? null : 'assets',
  );
  final _controller3 =
      TextEditingController(text: Get.parameters['access_token']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Focus.of(Get.context!).requestFocus(FocusNode()),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputView(),
            SizedBox(height: 32),
            reqBtnView(),
          ],
        ),
      ),
    );
  }

  Widget reqBtnView() {
    return ElevatedButton(
      onPressed: () async {
        Focus.of(Get.context!).requestFocus(FocusNode());

        try {
          Loading.show('请求中');
          await Git.init(
            owner: _controller1.text.isEmpty ? null : _controller1.text,
            repo: _controller2.text.isEmpty ? null : _controller2.text,
            token: _controller3.text.isEmpty ? null : _controller3.text,
          );
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
          return;
        } finally {
          await Loading.close();
        }

        await Get.offAllNamed(RoutesNamespace.home);
      },
      child: Text('确认'),
    );
  }

  Widget inputView() {
    return Container(
      width: Get.context!.isPhone ? null : 240,
      padding: EdgeInsets.symmetric(horizontal: Get.context!.isPhone ? 48 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _textField(controller: _controller1, hintText: '用户'),
          SizedBox(height: 12),
          _textField(controller: _controller2, hintText: '仓库'),
          SizedBox(height: 12),
          _textField(controller: _controller3, hintText: '凭证'),
        ],
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        hintStyle: TextStyle(fontWeight: FontWeight.bold),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        enabledBorder: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
      ),
    );
  }

  final _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32),
    borderSide: BorderSide.none,
  );
}
