import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/tools/git/git.dart';

class AlertDialogPickImages extends StatefulWidget {
  const AlertDialogPickImages({
    Key? key,
    required this.images,
  }) : super(key: key);
  final List<XFile> images;

  @override
  _AlertDialogPickImagesState createState() => _AlertDialogPickImagesState();
}

class _AlertDialogPickImagesState extends State<AlertDialogPickImages> {
  final List<Uint8List> memorys = [];
  final List<XFile> images = [];

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    final List<Uint8List> temp = [];
    for (var item in widget.images) {
      final data = await item.readAsBytes();
      temp.add(data);
    }

    setState(() {
      images.addAll(widget.images);
      memorys.addAll(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '确认图片',
        style: TextStyle(color: Colors.black),
      ),
      content: SizedBox(
        width: Get.width * .6,
        height: Get.height * .6,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: MemoryImage(memorys[index]),
                ),
              ),
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    images.removeAt(index);
                    memorys.removeAt(index);
                  });
                },
                icon: Icon(Icons.delete),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(images),
          child: Text('上传'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
      ],
    );
  }
}

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
              text = '我新提交了图片';
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
