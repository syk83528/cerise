import 'package:share_plus/share_plus.dart';

class Shares {
  static share(String text) async {
    await Share.share(text);
  }
}
