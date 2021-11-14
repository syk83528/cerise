import 'package:get/get.dart';

class Model {
  final String name;
  final String desc;
  final List<PartModel> parts;

  Model({
    required this.name,
    required this.desc,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    map['name'] = name;
    map['desc'] = desc;
    map['parts'] = List.generate(
      parts.length,
      (index) => parts[index].toMap(),
    );

    return map;
  }
}

class PartModel {
  String image;
  final dialogs = <DialogModel>[].obs;

  PartModel({
    this.image = '',
    List<DialogModel> dialogs = const [],
  }) {
    this.dialogs.addAll(dialogs);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    map['image'] = image;
    map['dialogs'] = List.generate(
      dialogs.length,
      (index) => dialogs[index].toMap(),
    );

    return map;
  }
}

class DialogModel {
  String role;
  String data;
  String? meta;

  DialogModel({
    required this.role,
    required this.data,
    this.meta,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    map['role'] = role;
    map['data'] = data;
    if (meta != null) {
      map['meta'] = meta;
    }

    return map;
  }
}
