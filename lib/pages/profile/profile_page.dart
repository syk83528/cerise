import 'dart:math';

import 'package:cerise/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cerise/widgets/button/button.dart';

import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/${Random().nextInt(990) + 99}.jpg',
              fit: BoxFit.cover,
            ),
          ),
          topView(),
          profileView(),
        ],
      ),
    );
  }

  Widget profileView() {
    return Positioned(
      left: 16,
      right: 16,
      top: 96,
      child: SafeArea(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: profileBodyView(),
        ),
      ),
    );
  }

  Widget profileBodyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          nickNameView(),
          SizedBox(height: 12),
          Text(
            '天堂梦境一级摄影师~',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          baseInfoView(),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(child: CountCardView(count: 10, label: '创建主题')),
              Expanded(child: CountCardView(count: 56, label: '关注主题')),
              Expanded(child: CountCardView(count: 12, label: '她关注的人')),
              Expanded(child: CountCardView(count: 4, label: '关注她的人')),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget baseInfoView() {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                children: [
                  ChipCard.text(data: '成都'),
                  ChipCard.text(data: '水瓶座'),
                  ChipCard.text(data: '博美犬'),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '我想变成那蜻蜓，脚步也变得轻盈',
                style: TextStyle(
                  color: Color(0xff9c9faa),
                ),
              ),
            ],
          ),
          followBtn(),
        ],
      ),
    );
  }

  Widget followBtn() {
    return Material(
      elevation: 3,
      color: Color(0xffff567a),
      borderRadius: BorderRadius.circular(32),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            colors: const [
              Color(0xffff829c),
              Color(0xffff567a),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
              Text(
                '关注',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nickNameView() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(64),
            image: DecorationImage(
              image: NetworkImage(
                  'https://cdn.jsdelivr.net/gh/mocaraka/assets/picture/1028.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Spacer(),
        Text(
          '魔咔啦咔',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/icons/msg.png',
            width: 32,
          ),
        ),
      ],
    );
  }

  Widget topView() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackBtn(color: Colors.white),
            IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(CupertinoIcons.arrow_up_right_circle),
            ),
          ],
        ),
      ),
    );
  }
}

class CountCardView extends StatelessWidget {
  const CountCardView({
    Key? key,
    required this.count,
    required this.label,
  }) : super(key: key);

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ChipCard extends StatelessWidget {
  const ChipCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  ChipCard.text({
    Key? key,
    required String data,
  })  : child = Text(
          data,
          style: TextStyle(color: Colors.grey),
        ),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xffe9e9e9),
        borderRadius: BorderRadius.circular(32),
      ),
      child: child,
    );
  }
}
