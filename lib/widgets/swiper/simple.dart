import 'dart:async';

import 'package:flutter/material.dart';

class SimpleSwiperView extends StatefulWidget {
  final List<Widget> children;
  final Duration interval;
  final ScrollPhysics scrollPhysics;

  const SimpleSwiperView({
    Key? key,
    required this.children,
    this.interval = const Duration(seconds: 3),
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  }) : super(key: key);

  SimpleSwiperView.network({
    Key? key,
    required List<String> images,
    this.interval = const Duration(seconds: 3),
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  })  : children =
            images.map((e) => Image.network(e, fit: BoxFit.cover)).toList(),
        super(key: key);

  SimpleSwiperView.asset({
    Key? key,
    required List<String> images,
    this.interval = const Duration(seconds: 3),
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  })  : children =
            images.map((e) => Image.asset(e, fit: BoxFit.cover)).toList(),
        super(key: key);

  @override
  _SimpleSwiperViewState createState() => _SimpleSwiperViewState();
}

class _SimpleSwiperViewState extends State<SimpleSwiperView> {
  final PageController _controller = PageController();
  late final Timer _timer;
  late final int _total;

  int _currentIdx = 0;

  @override
  void initState() {
    super.initState();
    _total = widget.children.length;
    _initTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: widget.children,
      physics: widget.scrollPhysics,
      onPageChanged: (int index) {
        setState(() {
          _currentIdx = index;
        });
      },
    );
  }

  void _initTimer() => _timer = Timer.periodic(widget.interval, _timerCallback);

  void _timerCallback(Timer timer) {
    _controller.jumpToPage((_currentIdx + 1) % _total);
  }
}
