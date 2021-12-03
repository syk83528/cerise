export 'io/mobile.dart';

import 'io/desktop.dart' if (dart.library.html) 'html/html.dart';

Future<void> open({
  required String url,
  String title = '',
}) async {
  await openIt(url, title);
}
