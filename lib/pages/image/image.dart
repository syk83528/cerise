import 'package:flutter/cupertino.dart';
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
        appBar: _AppBar(label: _controller.name.value),
        body: CupertinoScrollbar(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: ScrollX.physics,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isPhone ? 2 : Get.width ~/ 120,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: _controller.images.length,
            itemBuilder: (context, index) {
              final url = _controller.images[index];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  await Get.to(LookPage(url: url));
                },
                onLongPress: () => _controller.moreOps(url),
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
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(),
      title: Text(label),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: ImageController.to.selectAndupload,
          icon: Icon(Icons.cloud_upload_rounded),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
