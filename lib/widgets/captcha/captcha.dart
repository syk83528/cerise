import 'package:flutter/material.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';

class Captcha extends StatelessWidget {
  const Captcha({
    Key? key,
    required this.answer,
    required this.onResult,
  }) : super(key: key);

  final void Function(bool) onResult;
  final List<int> answer;

  @override
  Widget build(BuildContext context) {
    return GesturePasswordWidget(
      lineColor: const Color(0xff0C6BFE),
      errorLineColor: const Color(0xffFB2E4E),
      singleLineCount: 3,
      identifySize: 80.0,
      minLength: 4,
      errorItem: Icon(Icons.error_rounded, color: Colors.red),
      normalItem: Icon(Icons.ac_unit_rounded, color: Colors.black),
      selectedItem: Icon(Icons.ac_unit, color: Colors.blue),
      answer: answer,
      color: Colors.white,
      onComplete: (data) {
        if (data.length != answer.length) return;
        for (var i = 0; i < data.length; i++) {
          if (data[i] != answer[i]) {
            onResult(false);
            return;
          }
        }

        onResult(true);
      },
    );
  }
}
