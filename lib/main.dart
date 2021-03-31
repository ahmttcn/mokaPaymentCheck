import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payment_check/Screens/LoginScreen.dart';
import 'package:payment_check/Screens/MainScreen.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Models/SharedPref.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      navigateAfterFuture:
          Future.delayed(Duration(milliseconds: 2500), () async {
        await SharedPref.init();
        if (await SharedPref.getLoggedIn() == "loggedIn") {
          return Future.value(new MainScreen());
        } else {
          return Future.value(new LoginScreen());
        }
      }),
      title: buildMainText(),
      photoSize: MediaQuery.of(context).size.width / 5,
      image: logoImage(),
      imageBackground: AssetImage('assets/images/background_sky.jpg'),
      backgroundColor: Colors.black,
      loaderColor: Colors.white,
      loadingText: loadingText(context),
      useLoader: true,
    );
  }

  Text buildMainText() {
    return new Text(
      'Hobitek Ödeme Sorgulama',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width / 20,
        color: Colors.white,
      ),
    );
  }

  Image logoImage() {
    return new Image(
      fit: BoxFit.cover,
      image: AssetImage('assets/images/logo_transparan.png'),
    );
  }

  Text loadingText(BuildContext context) {
    return Text(
      "Loading Please Wait...",
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width / 30),
    );
  }
}
