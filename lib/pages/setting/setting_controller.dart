import 'package:get/get.dart';

import 'package:cerise/tools/git/git.dart';
import 'package:cerise/widgets/loading/loading.dart';

class SettingController extends GetxController {
  final username = ''.obs;
  final avatar = ''.obs;
  final isGitHub = false.obs;
  final isPrivate = false.obs;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    final profile = await Git.getProfile();
    username.value = profile[0] ?? 'Unknown';
    avatar.value = profile[1] ?? '';

    isGitHub.value = Git.registryIsGitHub;
    isPrivate.value = Git.repoIsPrivate;
  }

  Future<void> switchRegistry() async {
    late final String message;

    try {
      Loading.show('更改中');
      if (Git.isPrivate) throw '该仓库是私有的，无法修改为其他源!';

      await Git.switchRegistry(!isGitHub.value);

      isGitHub.value = !isGitHub.value;
      message = '成功更改为：' + (isGitHub.value ? 'GitHub' : 'JSDelivr');
    } catch (e) {
      message = e.toString();
    } finally {
      await Loading.close();
      Get.snackbar('仓库源', message);
    }
  }

  Future<void> changeVisual() async {
    late final String message;

    try {
      Loading.show('更改中');
      await Git.changeRepoVisual();

      message = '更改为: ' + (!isPrivate.value ? '私有' : '公开');
      isPrivate.value = !isPrivate.value;
      isGitHub.value = true;
    } catch (e) {
      message = '更改失败: ${e.toString()}';
    } finally {
      await Loading.close();
      Get.snackbar('仓库可见性', message);
    }
  }
}
