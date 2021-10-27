import 'package:wakelock/wakelock.dart';

class Screen {
  static Future<void> lock() => Wakelock.enable();

  static Future<void> unlock() => Wakelock.disable();
}
