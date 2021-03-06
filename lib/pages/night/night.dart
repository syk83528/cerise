import 'dart:math';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/router/router.dart';
import 'package:cerise/styles/styles.dart';
import 'package:cerise/tools/time_format/time_format.dart';

import 'controller.dart';

class NightPage extends StatefulWidget {
  const NightPage({Key? key}) : super(key: key);

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<NightPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    Get.put(NightController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          pinnedHeaderSliverHeightBuilder: () {
            return kToolbarHeight;
          },
          physics: ScrollX.physics,
          headerSliverBuilder: _getHeaderSliverBuilder,
          body: TabBarView(
            controller: tabController,
            children: [
              exploreView(),
              Center(child: Text('TODO')),
            ],
          ),
        ),
      ),
    );
  }

  Widget exploreView() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
          physics: ScrollX.physics,
          shrinkWrap: true,
          itemCount: NightController.to.images.length,
          itemBuilder: (context, index) {
            return GalleryWidget(
              name: '魔咔啦咔',
              uid: 20,
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/696.jpg',
              pid: 'sfa',
              text: '美少女出锅啦',
              images: NightController.to.images[index],
              tags: const ['桜桃喵', '写真集'],
              timestamp: 1633070264000,
            );
          }),
    );
  }

  List<Widget> _getHeaderSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return [
      appBar(),
      persistentHeader(),
    ];
  }

  SliverPersistentHeader persistentHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomDelegate(
        child: TabBar(
          labelPadding: const EdgeInsets.symmetric(vertical: 16),
          physics: ScrollX.physics,
          controller: tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          tabs: const [
            Text('探索'),
            Text('动态'),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      expandedHeight: 160,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share_rounded),
          tooltip: '写真分享',
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.cloud_upload_rounded),
          tooltip: '上传写真',
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            activeFriendView(
              name: '魔咔啦咔1',
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/375.jpg',
              uid: 23,
            ),
            activeFriendView(
              name: '魔咔啦咔2',
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/753.jpg',
              uid: 23,
            ),
            activeFriendView(
              name: '魔咔啦咔3',
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/951.jpg',
              uid: 23,
            ),
            activeFriendView(
              name: '魔咔啦咔4',
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/877.jpg',
              uid: 23,
            ),
            activeFriendView(
              name: '魔咔啦咔5',
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/333.jpg',
              uid: 23,
            ),
            activeFriendView(
              name: '魔咔啦咔6',
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/441.jpg',
              uid: 23,
            ),
            activeFriendView(
              name: '魔咔啦咔7',
              avatar:
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/555.jpg',
              uid: 23,
            ),
          ],
        ),
      ),
    );
  }

  Widget activeFriendView({
    required String name,
    required String avatar,
    required int uid,
  }) {
    return Column(
      children: [
        SizedBox(height: 52, width: 72),
        InkWell(
          onTap: () {
            // TODO: 跳转到她的空间
          },
          borderRadius: BorderRadius.circular(40),
          child: CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(avatar),
            child: SizedBox(width: 72, height: 72),
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: 80,
          alignment: Alignment.center,
          child: Text(name, maxLines: 2),
        ),
      ],
    );
  }
}

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    Key? key,
    required this.name,
    required this.uid,
    required this.avatar,
    required this.pid,
    required this.text,
    required this.images,
    required this.tags,
    required this.timestamp,
  }) : super(key: key);

  final String name;
  final int uid;
  final String avatar;
  final String pid;
  final String text;
  final List<String> images;
  final List<String> tags;
  final int timestamp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Map<String, String> params = {'p': pid};
        await Get.toNamed(RoutesNamespace.browser,
            parameters: params, arguments: images);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        color: Colors.white,
        margin: MP.screenAll,
        child: coreView(),
      ),
    );
  }

  Widget coreView() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          infoView(),
          SizedBox(height: 6),
          Text(text),
          SizedBox(height: 4),
          tagView(),
          SizedBox(height: 16),
          imageView(),
        ],
      ),
    );
  }

  Wrap tagView() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: List.generate(
        tags.length,
        (index) => TagWidget(
          text: tags.elementAt(index),
        ),
      ),
    );
  }

  Widget imageView() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Get.width ~/ 120,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      children: List.generate(
        images.length > 9 ? 9 : images.length,
        (index) => imageCard(index),
      ),
    );
  }

  Widget imageCard(int index) {
    return InkWell(
      onTap: () async {
        Map<String, String> params = {'p': pid, 'offset': index.toString()};
        await Get.toNamed(
          RoutesNamespace.browser,
          parameters: params,
          arguments: images,
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          images.elementAt(index),
          fit: BoxFit.cover,
          cacheWidth: 240,
        ),
      ),
    );
  }

  Widget infoView() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(avatar),
          child: SizedBox(width: 48, height: 48),
        ),
        SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, maxLines: 1),
              Text(TimeFormat.getAgo(timestamp)),
            ],
          ),
        ),
      ],
    );
  }
}

class TagWidget extends StatelessWidget {
  TagWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  final Color color = _colors.elementAt(_random.nextInt(_colors.length));

  static final _random = Random(DateTime.now().millisecondsSinceEpoch);
  static const List<Color> _colors = [
    Color(0xffa7bee3),
    Color(0xff986ffa),
    Color(0xff000000),
    Color(0xff393555),
    Color(0xff8acac0),
    Color(0xff6f5261),
    Color(0xffd094b0),
    Color(0xffe9a79b),
    Color(0xffe4a0a0),
    Color(0xfff2af73),
    Color(0xfffff0b3),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: RawChip(
        label: Text(
          text,
          style: TextStyle(color: _sureColor()),
        ),
        avatar: Icon(
          CupertinoIcons.cube_fill,
          color: _sureColor(),
          size: 16,
        ),
        backgroundColor: color,
      ),
    );
  }

  Color _sureColor() {
    return color.red < 160 ? Colors.white : Colors.black;
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  const CustomDelegate({
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

/// 图标牌子
class BrandWidget extends StatelessWidget {
  const BrandWidget({
    Key? key,
    required this.icon,
    required this.brand,
    this.color,
    this.textColor,
    this.onClick,
  }) : super(key: key);

  final IconData icon;
  final String brand;

  final Color? color;
  final Color? textColor;

  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: onClick,
          customBorder: CircleBorder(),
          child: Icon(
            icon,
            color: color,
            size: 40,
          ),
        ),
        Text(
          brand,
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }
}
