import 'package:fluro_study/router.dart';
import 'package:flutter/material.dart';

void main() {
  // 初始化路由
  FluroRouter.setupRouter();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fluro Tutorial',
        // 初始化页面为登陆页
        initialRoute: 'login',
        // 使用Fluro 提供的 插件
        onGenerateRoute: FluroRouter.router.generator
    );
  }
}