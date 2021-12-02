import 'dart:async';

import 'package:flutter/material.dart';

class SwiperView extends StatefulWidget {
  final List<Widget> children;
  final Curve curve;
  final Duration interval;
  final ScrollPhysics scrollPhysics;

  const SwiperView({
    Key? key,
    required this.children,
    this.curve = Curves.ease,
    this.interval = const Duration(seconds: 3),
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  }) : super(key: key);

  SwiperView.network({
    Key? key,
    required List<String> images,
    this.curve = Curves.ease,
    this.interval = const Duration(seconds: 3),
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  })  : children =
            images.map((e) => Image.network(e, fit: BoxFit.cover)).toList(),
        super(key: key);

  SwiperView.asset({
    Key? key,
    required List<String> images,
    this.curve = Curves.ease,
    this.interval = const Duration(seconds: 3),
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  })  : children =
            images.map((e) => Image.asset(e, fit: BoxFit.cover)).toList(),
        super(key: key);

  @override
  _SwiperViewState createState() => _SwiperViewState();
}

class _SwiperViewState extends State<SwiperView> {
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
    return PageView.builder(
      controller: _controller,
      physics: widget.scrollPhysics,
      onPageChanged: (int index) {
        setState(() {
          _currentIdx = index;
        });
      },
      itemBuilder: (context, index) {
        return widget.children[index % _total];
      },
    );
  }

  void _initTimer() => _timer = Timer.periodic(widget.interval, _timerCallback);

  void _timerCallback(Timer timer) {
    _controller.animateToPage(
      ++_currentIdx,
      duration: Duration(milliseconds: 200),
      curve: widget.curve,
    );
  }
}
