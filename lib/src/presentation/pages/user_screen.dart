import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'User Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
