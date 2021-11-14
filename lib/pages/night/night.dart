import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class NightPage extends StatelessWidget {
  NightPage({Key? key}) : super(key: key);

  final _controller = Get.put(NightController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: bodyView(),
    );
  }

  ListView bodyView() {
    return ListView.builder(
      itemCount: _controller.tabs.length,
      itemBuilder: (context, index) {
        final data = _controller.tabs[index];
        return ListTile(
          title: Text(data.label),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () => Get.toNamed(data.route),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
