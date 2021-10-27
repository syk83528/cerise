import 'package:flutter/material.dart';

import 'package:cerise/assets/assets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetImages.empty,
      fit: BoxFit.contain,
    );
  }
}
