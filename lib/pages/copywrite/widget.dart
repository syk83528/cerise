import 'package:flutter/material.dart';

import 'model.dart';

class InputDialogDialog extends StatelessWidget {
  InputDialogDialog({
    Key? key,
    required this.initRole,
    required this.initData,
    this.initMeta,
  })  : _controller1 = TextEditingController(text: initRole),
        _controller2 = TextEditingController(text: initData),
        _controller3 = TextEditingController(text: initMeta),
        super(key: key);

  final String initRole;
  final String initData;
  final String? initMeta;

  final TextEditingController _controller1;
  final TextEditingController _controller2;
  final TextEditingController _controller3;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '编辑信息',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller1,
            decoration: InputDecoration(labelText: '角色'),
          ),
          TextField(
            controller: _controller2,
            decoration: InputDecoration(labelText: '内容'),
          ),
          TextField(
            controller: _controller3,
            decoration: InputDecoration(
              labelText: '其他',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final item = DialogModel(
              role: _controller1.text,
              data: _controller2.text,
              meta: _controller3.text.isEmpty ? null : _controller3.text,
            );
            Navigator.of(context).pop(item);
          },
          child: Text('确认'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消'),
        ),
      ],
    );
  }
}

class InputImageDialog extends StatelessWidget {
  InputImageDialog({
    Key? key,
    required this.value,
  })  : _controller = TextEditingController(text: value),
        super(key: key);

  final String value;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '输入画面信息',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: '画面信息'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text('确认'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
      ],
    );
  }
}

class InputMetaDialog extends StatelessWidget {
  InputMetaDialog({
    Key? key,
  }) : super(key: key);

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '编辑信息',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller1,
            decoration: InputDecoration(labelText: '名称'),
          ),
          TextField(
            controller: _controller2,
            decoration: InputDecoration(labelText: '简介'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(
              {
                'name': _controller1.text,
                'desc': _controller2.text,
              },
            );
          },
          child: Text('确认'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
      ],
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '提示',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: Text('你确定要删除吗？'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('确认'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
      ],
    );
  }
}
