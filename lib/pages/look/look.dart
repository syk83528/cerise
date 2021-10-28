import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:cerise/widgets/button/button.dart';
import 'package:cerise/widgets/empty/empty.dart';

class LookPage extends StatelessWidget {
  const LookPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageView(),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: BackBtn(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget imageView() {
    return PhotoView(
      enableRotation: true,
      initialScale: PhotoViewComputedScale.contained * .6,
      imageProvider: NetworkImage(url),
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
      errorBuilder: (ctx, a, b) {
        return Center(child: EmptyWidget());
      },
    );
  }
}
