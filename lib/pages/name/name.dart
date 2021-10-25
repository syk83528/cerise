import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/styles/styles.dart';

import 'controller.dart';

class NamePage extends StatelessWidget {
  NamePage({
    Key? key,
    required this.isVideo,
  }) : super(key: key);

  final bool isVideo;

  final _controller = Get.put(NameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return SafeArea(
      child: Obx(
        () => ListView.builder(
          physics: ScrollX.physics,
          itemCount: _controller.names.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_controller.names[index]),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () async {
                final params = {'name': _controller.names[index]};
                await Get.toNamed(isVideo ? RoutesNamespace.video:RoutesNamespace.image, parameters: params);
              },
            );
          },
        ),
      ),
    );
  }
}
