import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pokedex/homepage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  startSplashTimer() {
    var _duration = new Duration(seconds: 9);
    return new Timer(_duration, navigateToHome);
  }

  navigateToHome() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomePage()
      )
    );
  }

  @override
  void initState() {
    startSplashTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: deviceHeight * 0.225,
            ),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(
      color: Colors.red, //                   <--- border color
      width: 5.0,
    ),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/pokeball.png")
                )
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.2,
            ),
            Text(
              "POKEDEX",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Pokemon Encyclopedia",
              style: TextStyle(
                color: Colors.white,
                height: 1,
                wordSpacing: 1.5,
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}