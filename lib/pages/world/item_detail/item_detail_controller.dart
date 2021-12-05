import 'package:get/get.dart';

class ItemDetailController extends GetxController {
  final title = '沸羊羊，你吃饭能不能斯文一点？'.obs;
  final content = '''今天有美羊羊内味了吗？
哈哈哈哈哈突然发现自己的卡通头饰真的很多！
朋友看了说动物园开会都没有我这么齐
不过冬天嘛！本来穿得就单调，毛衣配饰还是得活泼可爱一些～
穿上整个人都开心了嘎嘎！
👔：诗凡黎
🐑：鹿系少女手作
🐻：朋友送滴
#来拍照了'''
      .obs;
  final images = <String>[
    'http://ci.xiaohongshu.com/b9586ae7-a9c7-386a-88ad-511b50c85a3d?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/751d8da6-c309-3bc6-b8ff-b35161c1409b?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/79c27c84-d8f4-31af-b2b3-39c7fee87ba7?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/9e750294-3f94-3723-95a2-92b45a3b197b?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/9c0e9969-b6a0-3a64-abc4-6c4a11b37715?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/b8c824ad-01a1-3924-ad6d-8877e5ef8535?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/2d9c6e8f-c0da-339f-8a92-17882fe5796e?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/87c96d8c-a86a-3428-b9ba-a7796baaa0cb?imageView2/2/w/1280/format/jpg',
    'http://ci.xiaohongshu.com/e6bdf3a9-bce2-383e-91e8-f43d0523b6c1?imageView2/2/w/1280/format/jpg',
  ].obs;
  final imageIdx = 0.obs;

  void onImageChanged(int index) {
    imageIdx.value = index;
  }
}
