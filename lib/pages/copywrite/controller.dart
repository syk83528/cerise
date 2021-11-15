import 'dart:convert';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json2yaml/json2yaml.dart';
import 'package:yaml/yaml.dart';

import 'package:cerise/tools/selector/selector.dart';

import 'model.dart';
import 'widget.dart';

class CopywritingController extends GetxController {
  final parts = <PartModel>[
    PartModel(
      image: '第一幕',
      dialogs: [
        DialogModel(role: '导演', data: '你在干嘛？'),
        DialogModel(role: '导演', data: '你在干嘛？'),
        DialogModel(role: '导演', data: '你在干嘛？'),
      ],
    ),
    PartModel(
      image: '第二幕',
      dialogs: [
        DialogModel(role: '主角', data: '哈哈哈'),
        DialogModel(role: '主角', data: '哈哈哈'),
        DialogModel(role: '主角', data: '哈哈哈'),
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

  Future<void> selectAndOpen() async {
    final group = XTypeGroup(
      label: '选择文案文件',
      extensions: ['.yaml'],
    );
    final file = await FileSelector.pickFile(acceptedTypeGroups: [group]);
    if (file == null) return;

    late final SnackBar snackBar;
    try {
      final data = await file.readAsString();
      final mapData = json.decode(json.encode(loadYaml(data)));

      final List<PartModel> temp = [];
      final partsData = mapData['parts'] as List;
      for (Map part in partsData) {
        String image = '';
        final List<DialogModel> dialogs = [];
        if (part.containsKey('image')) {
          image = part['image'];
        }
        if (part.containsKey('dialogs')) {
          final value = part['dialogs'] as List;
          for (Map item in value) {
            final dia = DialogModel(
              role: item['role'] ?? '',
              data: item['data'] ?? '',
              meta: item['meta'],
            );
            dialogs.add(dia);
          }
        }

        final value = PartModel(
          image: image,
          dialogs: dialogs,
        );
        temp.add(value);
      }

      parts.clear();
      parts.addAll(temp);

      snackBar = SnackBar(content: Text('加载成功'));
    } catch (e) {
      snackBar = SnackBar(content: Text('加载失败：${e.toString()}'));
    } finally {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<void> addDialog(int index) async {
    final dialog = parts[index].dialogs;
    dialog.add(DialogModel(role: '', data: ''));
  }

  Future<void> deletePart(int index) async {
    final value = await showDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return DeleteDialog();
      },
    );

    if (value == null || !value) return;
    parts.removeAt(index);
  }

  Future<void> changeImage(int index) async {
    final part = CopywritingController.to.parts[index];
    final value = await showDialog<String>(
      context: Get.context!,
      builder: (context) {
        return InputImageDialog(value: part.image);
      },
    );

    if (value == null) return;
    part.image = value;
  }
}
