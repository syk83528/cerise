import 'package:flutter/material.dart';

import 'package:cerise/tools/git/git.dart';

class AlertDialogInputView extends StatelessWidget {
  AlertDialogInputView({Key? key}) : super(key: key);

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '请输入提交信息',
        style: TextStyle(color: Colors.black),
      ),
      content: TextField(
        controller: _controller,
      ),
      actions: [
        TextButton(
          onPressed: () {
            String text = _controller.text;
            if (text.isEmpty) {
              text = '我新提交了视频';
            }
            text += '\n------\nhttps://github.com/${Git.repo}';

            Navigator.of(context).pop(text);
          },
          child: Text('确定'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
      ],
    );
  }
}
