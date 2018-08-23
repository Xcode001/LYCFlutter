import 'package:flutter/material.dart';
import 'package:flutter_lyc/base/page/home_page.dart';
import 'package:flutter_lyc/base/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'LYC Clinic Flutter Demo',
      color: Colors.white,
      theme: themeData,
      home: new MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }

}
