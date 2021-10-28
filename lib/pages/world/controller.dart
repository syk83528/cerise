import 'package:get/get.dart';

import 'model.dart';

class WorldController extends GetxController {
  final items = <WorldItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    final temp = List.generate(
      32,
      (index) => WorldItemModel(
        username: '茜茜公主',
        avatar: 'https://avatars.githubusercontent.com/u/60403489?s=128&v=4',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        url: 'https://github.com/ggdream/assets',
        message: '我又提交了新的图片',
      ),
    );
    items.addAll(temp);
  }
}
