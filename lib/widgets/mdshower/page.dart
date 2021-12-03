import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MDShowerPage extends StatefulWidget {
  const MDShowerPage({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  _MDShowerPageState createState() => _MDShowerPageState();
}

class _MDShowerPageState extends State<MDShowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Markdown(data: widget.data),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: BackButton(),
      title: Text(widget.title),
      centerTitle: true,
    );
  }
}
