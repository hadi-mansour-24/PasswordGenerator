import 'package:flutter/material.dart';
import 'PasswordGenerator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Generator',
      theme: ThemeData(
      primarySwatch: Colors.grey,
      hintColor: Colors.white70,
      brightness: Brightness.dark,
      fontFamily: 'Roboto',
      ),
    home: PasswordGenerator(),
    );
  }
}
