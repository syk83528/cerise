import 'package:flutter/material.dart';

import 'core.dart';
import 'preview.dart';

export 'init.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Preview(
      child: Core(),
    );
  }
}
