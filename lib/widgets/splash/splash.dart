import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    Key? key,
    required this.future,
    this.icon,
    this.footer,
    this.page,
    this.errPage,
    this.route,
    this.errRoute,
    this.color,
    this.backgroundColor,
    this.backgroundImage,
  })  : assert(!(page == null && route == null)),
        assert(!(errPage == null && errRoute == null)),
        assert(!(icon == null && footer != null)),
        super(key: key);

  final Future future;
  final String? icon;
  final String? footer;

  final Widget? page;
  final Widget? errPage;
  final String? route;
  final String? errRoute;

  final Color? color;
  final Color? backgroundColor;
  final DecorationImage? backgroundImage;

  @override
  Widget build(BuildContext context) {
    future
        .then((_) => _pageSwitch(context, page, route))
        .catchError((_) => _pageSwitch(context, errPage, errRoute));

    return coreView();
  }

  Widget coreView() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          image: backgroundImage,
        ),
        child: logoView(),
      ),
    );
  }

  Widget? logoView() {
    if (icon == null) return null;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(icon!, width: 256),
          Text(
            footer ?? '',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _pageSwitch(BuildContext context, Widget? page, String? route) {
    if (page != null) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) {
            return page;
          },
        ),
      );
    } else if (route != null) {
      Navigator.of(context).popAndPushNamed(route);
    }
  }
}
