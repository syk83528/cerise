import 'package:get/get.dart';

import 'package:cerise/tools/git/git.dart';

class ProfileController extends GetxController {
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
  }
}
