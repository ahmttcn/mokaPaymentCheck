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

class _MainScreenState extends State<MainScreen>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<MainScreen> {
  TabController _tabController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text('Ödeme Sorgulama'),
              backgroundColor: HexColor("1f1f1f"),
              centerTitle: true,
              pinned: false,
              floating: true,
              snap: true,
              stretch: true,
              forceElevated: innerBoxIsScrolled,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(child: Icon(Icons.home)),
                  Tab(child: Icon(Icons.person)),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            QueryScreen(),
            Profile(),
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
