import 'package:get/get.dart';

class NightController extends GetxController {
  var current = 0.obs;

  var images = <List<String>>[
    [
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/1.jpg',
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/2.jpg',
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/3.jpg',
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/4.jpg',
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/5.jpg',
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/6.jpg',
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/7.jpg',
      'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/8.jpg',
    ],
  ].obs;

  static NightController to = Get.find();

  @override
  void onInit() {
    super.onInit();
    List<List<String>> temp = [];
    for (var i = 0; i < 197; i++) {
      temp.add(
        List.generate(
          9,
          (index) =>
              'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/${i * 9 + index}.jpg',
        ),
      );
    }
    images.addAll(temp);
  }
}
