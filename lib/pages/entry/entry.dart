import 'package:cerise/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/tools/git/git.dart';

class EntryPage extends StatelessWidget {
  EntryPage({Key? key}) : super(key: key);

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.isPhone ? null : 240,
              padding:
                  EdgeInsets.symmetric(horizontal: context.isPhone ? 48 : 0),
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
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  Loading.show('请求中');
                  await Git.init(
                    owner: _controller1.text.isEmpty ? null : _controller1.text,
                    repo: _controller2.text.isEmpty ? null : _controller2.text,
                    token: _controller3.text.isEmpty ? null : _controller3.text,
                  );
                  await Loading.close();
                } catch (e) {
                  final snackBar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                await Get.offAllNamed(RoutesNamespace.home);
              },
              child: Text('确认'),
            ),
          ],
        ),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
