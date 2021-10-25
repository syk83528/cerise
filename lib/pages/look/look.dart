import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class LookPage extends StatelessWidget {
  const LookPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(url),
    );
  }
}
