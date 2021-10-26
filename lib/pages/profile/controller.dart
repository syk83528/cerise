import 'package:get/get.dart';

import 'package:cerise/tools/git/git.dart';

class ProfileController extends GetxController {
  final username = ''.obs;
  final avatar = ''.obs;
  final isGitHub = false.obs;

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
  }

  Future<void> switchRegistry() async {
    late final String message;

    try {
      if (Git.isPrivate) throw 'The repo is private!';

      isGitHub.value = !isGitHub.value;
      await Git.switchRegistry(isGitHub.value);

      message = '更改成功';
    } catch (e) {
      message = e.toString();
    } finally {
      Get.snackbar('CDN源', message);
    }
  }
}
