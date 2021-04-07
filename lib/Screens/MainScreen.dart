import 'package:flutter/material.dart';
import 'package:payment_check/Models/SharedPref.dart';
import 'package:payment_check/Screens/LoginScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: true,
      ),
      body: new Center(
        child: Column(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            new Text(
              "Succeeded!",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            IconButton(icon: Icon(Icons.logout), onPressed: logOut),
          ],
        ),
      ),
    );
  }

  logOut() async {
    await SharedPref.logOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
