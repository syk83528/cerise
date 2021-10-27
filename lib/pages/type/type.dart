import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/widgets/button/button.dart';

class TypePage extends StatelessWidget {
  TypePage({Key? key}) : super(key: key);

  final String? _name = Get.parameters['name'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        title: Text(_name ?? ''),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _cardWidget(
              '图片',
              CupertinoIcons.camera_circle,
              RoutesNamespace.image,
              Color(0xffa7bee3),
            ),
            SizedBox(height: 32),
            _cardWidget(
              '视频',
              CupertinoIcons.videocam_circle,
              RoutesNamespace.video,
              Color(0xffe9a79b),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardWidget(
    String label,
    IconData iconData,
    String route,
    Color color,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () async {
        if (_name == null) {
          Get.back();
        } else {
          final Map<String, String> params = {'name': _name!};
          await Get.toNamed(route, parameters: params);
        }
      },
      child: Tooltip(
        message: label,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(32),
          ),
          alignment: Alignment.center,
          child: Icon(
            iconData,
            size: 64,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
