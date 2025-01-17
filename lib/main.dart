import 'package:flutter/material.dart';
import '../pages/login_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(),
    );
  }
}
