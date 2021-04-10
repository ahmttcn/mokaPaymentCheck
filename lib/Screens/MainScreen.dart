import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:payment_check/Models/SharedPref.dart';
import 'package:payment_check/Screens/LoginScreen.dart';
import 'package:payment_check/Screens/Profile.dart';
import 'package:payment_check/Screens/QueryScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text('Ödeme Sorgulama'),
              backgroundColor: HexColor("1f1f1f"),
              centerTitle: true,
              pinned: false,
              floating: true,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(child: Icon(Icons.home)),
                  Tab(child: Icon(Icons.person)),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            QueryScreen(),
            Profile(),
          ],
        ),
      )),
    );
  }

  logOut() async {
    await SharedPref.logOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
