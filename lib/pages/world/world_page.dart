import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/styles/styles.dart';
import 'package:cerise/tools/notify/notify.dart';

import 'world_controller.dart';

class WorldPage extends StatelessWidget {
  WorldPage({Key? key}) : super(key: key);

  final _controller = Get.put(WorldController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: bodyView(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'world',
        onPressed: () {
          AppNotify.show(title: 'title', body: 'body');
        },
      ),
    );
  }

  Widget bodyView() {
    return Obx(() {
      return ListView.builder(
        // controller: _controller.scrollController,
        padding: const EdgeInsets.all(12),
        physics: ScrollX.physics,
        itemCount: _controller.items.length,
        itemBuilder: (context, index) {
          final item = _controller.items[index];
          return InkWell(
            onTap: () => Get.toNamed(RoutesNamespace.worldItemDetail),
            onLongPress: () => _controller.onPressItem(index),
            borderRadius: BorderRadius.circular(16),
            child: UniversalCard(
              username: item.username,
              avatar: item.avatar,
              timestamp: item.timestamp,
              url: item.url,
              message: item.message,
            ),
          );
        },
      );
    });
  }
}

class UniversalCard extends StatelessWidget {
  const UniversalCard({
    Key? key,
    required this.username,
    required this.avatar,
    required this.timestamp,
    required this.url,
    required this.message,
  }) : super(key: key);

  final String username;
  final String avatar;
  final int timestamp;
  final String url;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: coreView(),
    );
  }

  Widget coreView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topView(),
        centerView(),
      ],
    );
  }

  Widget centerView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget topView() {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          avatar,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(username),
      subtitle: Text(
        DateTime.now().toString(),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('世界'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(RoutesNamespace.tool),
          icon: Icon(Icons.work_outline_rounded),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
