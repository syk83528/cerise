import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/pages/look/look.dart';
import 'package:cerise/styles/styles.dart';

import 'controller.dart';

class ImagePage extends StatelessWidget {
  ImagePage({Key? key}) : super(key: key);

  final _controller = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(_controller.name.value),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          physics: ScrollX.physics,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.isPhone ? 2 : Get.width ~/ 120,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _controller.images.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await Get.to(LookPage(url: _controller.images[index]));
              },
              child: ClipRRect(
                child: Image.network(
                  _controller.images.elementAt(index),
                  fit: BoxFit.cover,
                  cacheWidth: 160,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            );
          },
        ),
      ),
    );
  }
}
