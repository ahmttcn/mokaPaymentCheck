import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:payment_check/Models/Firm.dart';
import 'package:payment_check/Models/SharedPref.dart';
import 'package:payment_check/Models/User.dart';
import 'package:payment_check/Screens/LoginScreen.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = SharedPref.getUser();
    Firm firm = SharedPref.getFirm();
    return Scaffold(
      backgroundColor: HexColor("262626"),
      body: Column(
        children: <Widget>[
          iconMethod(context, user),
          SizedBox(
            height: 40,
          ),
          Column(
            children: <Widget>[
              bottomInfos(context,
                  icon: Icons.qr_code, text: "Seri No:" + firm.serialId),
              sizedBox(height: 10),
              bottomInfos(context, icon: Icons.mail, text: user.email),
              sizedBox(height: 10),
              bottomInfos(context,
                  icon: Icons.mobile_friendly, text: user.phoneNumber),
              sizedBox(height: 10),
              bottomInfos(context,
                  icon: Icons.home,
                  text: user.address + "\n" + user.state + "/" + user.city),
              sizedBox(height: 40),
              TextButton(
                onPressed: () async {
                  await SharedPref.logOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text(
                        "Çıkış Yap",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox sizedBox({double height, double width}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Row bottomInfos(BuildContext context, {IconData icon, String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        sizedBox(width: 10),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Container iconMethod(BuildContext context, User user) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: HexColor("454545"),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person_pin_circle_sharp,
              size: MediaQuery.of(context).size.width / 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              user.name + " " + user.surname,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
