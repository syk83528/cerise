import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:cerise/styles/styles.dart';
import 'package:cerise/widgets/button/button.dart';

import 'controller.dart';
import 'model.dart';

class CopywritingPage extends StatelessWidget {
  CopywritingPage({Key? key}) : super(key: key);

  final _controller = Get.put(CopywritingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: bodyView(),
      floatingActionButton: floatingBtn(),
    );
  }

  FloatingActionButton floatingBtn() {
    return FloatingActionButton(
      onPressed: () {
        final item = PartModel();
        CopywritingController.to.parts.add(item);
      },
      child: Icon(
        Icons.add_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget bodyView() {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        itemCount: _controller.parts.length,
        itemBuilder: (context, index) {
          return CopywritingCard(
            index: index,
            model: _controller.parts[index],
          );
        },
      );
    });
  }
}

class CopywritingCard extends StatelessWidget {
  const CopywritingCard({
    Key? key,
    required this.index,
    required this.model,
  }) : super(key: key);

  final int index;
  final PartModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: mainView(),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget mainView() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          showView(),
          buttonView(),
        ],
      ),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: ColorsX.green,
            width: 4,
          ),
        ),
      ),
    );
  }

  Widget buttonView() {
    return ButtonBar(
      children: [
        IconButton(
          onPressed: () => CopywritingController.to.addDialog(index),
          icon: Icon(Icons.add_rounded),
        ),
        IconButton(
          onPressed: () => CopywritingController.to.deletePart(index),
          icon: Icon(Icons.delete_outline_rounded),
        ),
        IconButton(
          onPressed: () => CopywritingController.to.changeImage(index),
          icon: Icon(Icons.camera_alt_rounded),
        ),
      ],
    );
  }

  Widget showView() {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.only(left: 24),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: model.dialogs.length,
        itemBuilder: (context, idx) {
          final data =
              CopywritingController.to.parts[index].dialogs.elementAt(idx);
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => CopywritingController.to.editDialog(
              partIndex: index,
              dialogIndex: idx,
              role: data.role,
              data: data.data,
              meta: data.meta,
            ),
            onLongPress: () => CopywritingController.to.deleteDialog(
              partIndex: index,
              dialogIndex: idx,
            ),
            child: CoptwritingItem(
              role: data.role,
              data: data.data,
              meta: data.meta,
            ),
          );
        },
      );
    });
  }
}

class CoptwritingItem extends StatelessWidget {
  const CoptwritingItem({
    Key? key,
    required this.role,
    required this.data,
    this.meta,
  }) : super(key: key);

  final String role;
  final String data;
  final String? meta;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        role,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      title: Text(data),
      subtitle: meta == null
          ? null
          : Text(
              meta!,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
      trailing: IconButton(
        onPressed: () async {
          final value = ClipboardData(text: data);
          await Clipboard.setData(value);
        },
        icon: Icon(Icons.copy_rounded),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackBtn(),
      title: Text('文案制作'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: CopywritingController.to.selectAndOpen,
          icon: Icon(Icons.cloud_circle_rounded),
          tooltip: '从本地读取',
        ),
        IconButton(
          onPressed: CopywritingController.to.download,
          icon: Icon(Icons.cloud_download_rounded),
          tooltip: '保存至本地',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
