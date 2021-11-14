import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json2yaml/json2yaml.dart';

import 'package:cerise/tools/selector/selector.dart';

import 'model.dart';
import 'widget.dart';

class CopywritingController extends GetxController {
  final parts = <PartModel>[
    PartModel(
      image: '和咯咯咯放大',
      dialogs: [
        DialogModel(role: '导演', data: '1'),
        DialogModel(role: '导演', data: '2'),
        DialogModel(role: '导演', data: '3'),
      ],
    ),
    PartModel(
      image: '和咯咯咯放大',
      dialogs: [
        DialogModel(role: '哈喽', data: '1'),
        DialogModel(role: '哈喽', data: '2'),
        DialogModel(role: '哈喽', data: '3'),
      ],
    ),
  ].obs;

  static CopywritingController get to => Get.find();

  Future<void> editDialog({
    required int partIndex,
    required int dialogIndex,
    required String role,
    required String data,
    String? meta,
  }) async {
    final value = await showDialog<DialogModel>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return InputDialogDialog(
          initRole: role,
          initData: data,
          initMeta: meta,
        );
      },
    );

    if (value == null) return;
    parts[partIndex].dialogs[dialogIndex] = value;
  }

  Future<void> deleteDialog({
    required int partIndex,
    required int dialogIndex,
  }) async {
    final value = await showDialog<bool>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return DeleteDialog();
      },
    );

    if (value == null || !value) return;

    final dialog = CopywritingController.to.parts[partIndex].dialogs;
    dialog.removeAt(dialogIndex);
  }

  Future<void> download() async {
    if (!GetPlatform.isDesktop) return;

    final value = await showDialog<Map<String, dynamic>>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return InputMetaDialog();
      },
    );

    if (value == null) return;

    late final SnackBar snackBar;
    try {
      final model = Model(
        name: value['name'],
        desc: value['desc'],
        parts: parts,
      );
      final yamlValue = json2yaml(model.toMap());
      final formatYamlValue = Uint8List.fromList(utf8.encode(yamlValue));

      await FileSelector.saveFile(
        name: '${value['name']}.yaml',
        data: formatYamlValue,
      );
       snackBar = SnackBar(content: Text('保存成功'));
    } catch (e) {
       snackBar = SnackBar(content: Text('保存失败：${e.toString()}'));
    } finally {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }
}
