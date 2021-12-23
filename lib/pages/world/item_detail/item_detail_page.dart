import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/styles/styles.dart';
import 'package:cerise/widgets/button/button.dart';

import 'item_detail_controller.dart';
import 'item_detail_widgets.dart';

class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({Key? key}) : super(key: key);

  final _controller = Get.put(ItemDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _AppBar(),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        scrollView(),
        bottomView(),
      ],
    );
  }

  Widget scrollView() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagesView(),
            archiveView(),
          ],
        ),
      ),
    );
  }

  Widget archiveView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textView(),
          metaView(),
          Divider(
            height: 0,
            thickness: .6,
            color: Color(0xffeaeaea),
          ),
          SizedBox(height: 24),
          Text(
            '共99条评论',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
          authorMockView(),
          SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/login/5.webp',
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '小榄',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                subtitle: Text('球球帽子好可爱啊'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border_rounded),
                ),
              );
            },
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              '- THE END -',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget authorMockView() {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/login/0.webp',
            width: 36,
            height: 36,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              '爱评论的人运气都不会差~',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ),
      ],
    );
  }

  Widget metaView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            '11-03',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            '不喜欢',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget bottomView() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 4,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: .6,
              color: Color(0xffeaeaea),
            ),
          ),
        ),
        child: Row(
          children: [
            textFieldMockView(),
            bottomActionsView(),
          ],
        ),
      ),
    );
  }

  Widget textFieldMockView() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          TextInputX.show(Get.context!);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            '说些什么叭...',
            maxLines: 1,
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget bottomActionsView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              color: Colors.black,
              icon: Icon(Icons.favorite_border_rounded),
            ),
            Text('235'),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/star_fill.png'),
            ),
            Text('235'),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/message.png'),
            ),
            Text('235'),
          ],
        ),
      ],
    );
  }

  Widget textView() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _controller.title.value,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(_controller.content.value),
        ],
      );
    });
  }

  Widget imagesView() {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              children: [
                PageView.builder(
                  onPageChanged: _controller.onImageChanged,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _controller.images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      _controller.images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 16, right: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${_controller.imageIdx.value + 1}/${_controller.images.length}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          PointIndicator(
            current: 0,
            total: 9,
            shown: 5,
          ),
        ],
      );
    });
  }
}

class PointIndicator extends StatefulWidget {
  const PointIndicator({
    Key? key,
    required this.current,
    required this.total,
    required this.shown,
  }) : super(key: key);

  final int current;
  final int total;
  final int shown;

  @override
  _PointIndicatorState createState() => _PointIndicatorState();
}

class _PointIndicatorState extends State<PointIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.shown, _surePoint),
    );
  }

  Widget _surePoint(int index) {
    if (widget.current == 0) {
      if (index == 0) return _activePoint();
      if (widget.total > widget.shown || index == widget.shown - 1) {
        return _smallPoint();
      }
      return _inactivePoint();
    } else if (widget.current == widget.total - 1) {
      if (index == widget.total - 1) return _activePoint();
      if (widget.total > widget.shown || index == 0) return _smallPoint();
      return _inactivePoint();
    }

    return _activePoint();
  }

  Widget _activePoint() {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Color(0xffff2442),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _inactivePoint() {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _smallPoint() {
    return Container(
      width: 4,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
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
      centerTitle: false,
      title: titleView(),
      actions: actionsView,
    );
  }

  List<Widget> get actionsView {
    return [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsX.red),
        ),
        alignment: Alignment.center,
        child: Text(
          '关注',
          style: TextStyle(color: ColorsX.red),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Image.asset('assets/icons/share.png'),
      ),
    ];
  }

  Widget titleView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/login/0.webp',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12),
        Text(
          '魔咔啦咔',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
