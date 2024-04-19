import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForumPage();
}

class _ForumPage extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Forum Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
