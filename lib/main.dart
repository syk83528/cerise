import 'package:flutter/material.dart';

import 'app/app.dart';

void main() async {
  await initialize();
  runApp(App());
  await initializeLate();
}
