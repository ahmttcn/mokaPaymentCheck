import 'dart:ui';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment_check/Models/Firm.dart';
import 'package:payment_check/Models/MokaFirmInfo.dart';
import 'package:payment_check/Models/SharedPref.dart';
import 'package:payment_check/Utils/Services.dart';
import 'package:payment_check/Utils/Urls.dart';
import 'dart:convert';

import 'LoginScreen.dart';

class AddFirm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddFirmState();
  }
}

class _AddFirmState extends State<AddFirm> {
  String qrCodeResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: buildBody(context),
    );
  }

  Stack buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          image: AssetImage("assets/images/background_sky.jpg"),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        buildComponents(context),
      ],
    );
  }

  Center buildComponents(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          buildTitle(context),
          buildScanButton(context),
          buildBottomText(context),
        ],
      ),
    );
  }

  Padding buildBottomText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: (MediaQuery.of(context).size.height * 0.15),
        //left: (MediaQuery.of(context).size.height * 0.10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[bottomMessage(context), buttomButton(context)],
      ),
    );
  }

  Padding buildScanButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: (MediaQuery.of(context).size.height * 0.5),
      ),
      child: FlatButton.icon(
        color: Colors.transparent,
        onPressed: () async {
          ScanResult codeScanner = await BarcodeScanner.scan(
            options: ScanOptions(useCamera: -1),
          );
          setState(() {
            qrCodeResult = codeScanner.rawContent;
          });
          await _checkUserQr(qrCodeResult).then((value) => alertDialog(value));
        },
        icon: Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
          size: MediaQuery.of(context).size.height * 0.065,
        ),
        label: Text(
          "SCAN QR",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Oranienbaum",
              fontSize: MediaQuery.of(context).size.height * 0.020),
        ),
        splashColor: Colors.brown[100],
      ),
    );
  }

  Future<bool> alertDialog(String message) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Sistem Mesajı"),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            )
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  Padding buildTitle(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.11)),
      child: Center(
        child: Column(
          children: <Widget>[
            VerticalDivider(
              endIndent: 10,
              color: Colors.black,
              width: 10,
              thickness: 10,
            ),
            Text(
              "Welcome To Steering Lab V2",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Oranienbaum",
                  fontSize: MediaQuery.of(context).size.height * 0.03),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _checkUserQr(String qrCodeResult) async {
    Map qrMap = json.decode(qrCodeResult);
    Map variables = new Map();
    String message;
    variables['dbUsername'] = qrMap['username'].toString();
    variables['dbPassword'] = qrMap['password'].toString();
    variables['addFirm'] = "addFirm";

    await Services.httpPost(Urls.addFirm, isJson: false, variables: variables)
        .then((response) async {
      Map responseMap = json.decode(response.body);

      if (responseMap['error'] == false) {
        Firm firm = Firm(
          username: qrMap['username'],
          password: qrMap['password'],
          serialId: qrMap['username'],
        );
        //print(responseMap['moka'].toString());
        MokaFirmInfo mokaFirmInfo;
        if (responseMap['message'] == "Moka") {
          mokaFirmInfo = new MokaFirmInfo.fromJson(responseMap['moka']);
          await SharedPref.addMoka(mokaFirmInfo).then((value) {
            if (value) {
              print("Moka added");
              message = "Moka Eklendi.";
            } else
              print("Error! Try Again");
          });
        }
        //print(mokaFirmInfo.dealerCode.toString());
        await SharedPref.addFirm(firm).then((value) {
          if (value) {
            print("Firm added");
            message = "Firma Eklendi.";
          } else
            print("Error! Try Again");
        });
      } else {
        print("Please check your internet connection");
        message = "Bir hata oluştu!";
      }
    });
    return message;
  }
}

FlatButton buttomButton(BuildContext context) {
  return FlatButton.icon(
    onPressed: () {},
    color: Colors.transparent,
    splashColor: Colors.brown[100],
    icon: Icon(
      Icons.login,
      color: Colors.white,
    ),
    label: Text(
      "Click Here.",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "monospace",
          fontSize: MediaQuery.of(context).size.height * 0.015),
    ),
  );
}

Text bottomMessage(BuildContext context) {
  return Text(
    "QR koda sahip değilseniz!",
    style: TextStyle(
        color: Colors.white,
        fontFamily: "monospace",
        fontSize: MediaQuery.of(context).size.height * 0.015),
  );
}
