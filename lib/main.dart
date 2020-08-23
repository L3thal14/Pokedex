
import 'package:flutter/material.dart';
import 'package:pokedex/splashpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Update Me',
      home: SplashPage(),
    );
  }
}