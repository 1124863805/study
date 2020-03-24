import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  final String username;
  HomePage({this.username});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Center(
        child: Text('欢迎你, $username!'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings_backup_restore),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "login");
        },
      ),
    );
  }
}