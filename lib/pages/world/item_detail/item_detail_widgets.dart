import 'dart:async';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class TextInputX {
  static OverlayEntry? _overlayEntry;

  static String? _textCache;

  static void show(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return TextInputXView();
      },
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  static void close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class TextInputXView extends StatefulWidget {
  const TextInputXView({Key? key}) : super(key: key);

  @override
  _TextInputXViewState createState() => _TextInputXViewState();
}

class _TextInputXViewState extends State<TextInputXView> {
  final _editingController = TextEditingController();
  late final StreamSubscription<bool> _subscription;
  final _focusNode = FocusNode();
  double _position = 0;
  bool _openEmoji = false;

  @override
  void initState() {
    super.initState();
    _subscription =
        KeyboardVisibilityController().onChange.listen(_listenKeyboardStatus);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _listenKeyboardStatus(bool status) {
    if (status) {
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          _position = MediaQuery.of(context).viewInsets.bottom;
          _openEmoji = false;
        });
      });
    } else if (!_openEmoji) {
      TextInputX.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: TextInputX.close,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                coreView(),
                if (_openEmoji)
                  Container(
                    height: _position,
                    color: Color(0xfffafafa),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 24,
                      ),
                      children: List.generate(
                        40,
                        (index) {
                          return GestureDetector(
                            onTap: () => _addEmoji(index),
                            child: Image.asset('assets/icons/emoji/$index.png'),
                          );
                        },
                      ),
                    ),
                  )
                else
                  SizedBox(height: _position),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addEmoji(int index) {
    final text = '[$index]';
    final selection = _editingController.selection;
    final start = selection.baseOffset;
    int end = selection.extentOffset;
    final value = _editingController.value;

    if (selection.isValid) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }
      _editingController.value = value.copyWith(
        text: newText,
        selection: selection.copyWith(
          baseOffset: end + text.length,
          extentOffset: end + text.length,
        ),
      );
    } else {
      _editingController.value = TextEditingValue(
        text: text,
        selection: TextSelection.fromPosition(
          TextPosition(offset: text.length),
        ),
      );
    }
  }

  Widget coreView() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: .4, color: Colors.grey.shade300),
        ),
      ),
      child: inputView(),
    );
  }

  Widget inputView() {
    return Row(
      children: [
        textView(),
        TextButton(
          onPressed: () {},
          child: Text(
            '发送',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            backgroundColor: Color(0xff5b92e2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ],
    );
  }

  Widget textView() {
    return Expanded(
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.only(
          left: 20,
          right: 8,
        ),
        decoration: BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(36),
        ),
        child: Row(
          children: [
            Expanded(
              child: ExtendedTextField(
                focusNode: _focusNode,
                controller: _editingController,
                cursorColor: Color(0xff5b92e2),
                cursorWidth: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 6),
                ),
                specialTextSpanBuilder: UpSpecialTextSpanBuilder(),
              ),
            ),
            const SizedBox(width: 6),
            GestureDetector(
              child: Image.asset(
                'assets/icons/input/at.png',
                width: 28,
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: _switchBetweenEmojiAndKeyboard,
              child: Image.asset(
                'assets/icons/input/${_openEmoji ? 'keyboard' : 'emoji'}.png',
                width: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _switchBetweenEmojiAndKeyboard() {
    setState(() {
      _openEmoji = !_openEmoji;
    });

    if (_openEmoji) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
  }
}

class EmojiText extends SpecialText {
  static const flag = '[';

  EmojiText({
    required this.start,
    required TextStyle? textStyle,
  }) : super(flag, ']', textStyle);

  final int start;

  @override
  InlineSpan finishText() {
    final key = toString();
    final emoji = AssetEmojis.get(key);
    if (emoji == null) {
      return TextSpan(text: key, style: textStyle);
    }

    return ImageSpan(
      AssetImage(emoji),
      actualText: key,
      imageWidth: 16,
      imageHeight: 16,
      start: start,
    );
  }
}

class UpSpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  @override
  SpecialText? createSpecialText(
    String flag, {
    TextStyle? textStyle,
    SpecialTextGestureTapCallback? onTap,
    required int index,
  }) {
    if (isStart(flag, EmojiText.flag)) {
      return EmojiText(
        start: index - (EmojiText.flag.length - 1),
        textStyle: textStyle,
      );
    }
  }
}

class AssetEmojis {
  static final _emojisList = List.generate(40, (index) => '[$index]');
  static Map<String, String>? _emojisMap;

  static String? get(String emoji) {
    if (_emojisMap == null) {
      final Map<String, String> temp = {};
      for (var i = 0; i < _emojisList.length; i++) {
        temp[_emojisList[i]] = 'assets/icons/emoji/$i.png';
      }
      _emojisMap = temp;
    }

    return _emojisMap![emoji];
  }
}
