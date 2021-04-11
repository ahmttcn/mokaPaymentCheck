import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:payment_check/Models/Firm.dart';
import 'package:payment_check/Models/SharedPref.dart';
import 'package:payment_check/Models/User.dart';
import 'package:payment_check/Screens/AddFirmScreen.dart';
import 'package:payment_check/Screens/MainScreen.dart';
import 'package:payment_check/Utils/Services.dart';
import 'package:payment_check/Utils/Urls.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      //overflow: Overflow.visible,
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        Image.asset(
          "assets/images/background_sky.jpg",
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: loginPage(context),
        ),
      ],
    );
  }
}

Widget loginPage(BuildContext context) {
  return new SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.15), BlendMode.dstATop),
          image: AssetImage('assets/images/background_sky.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          loginIcon(),
          textFieldLabel("Kullanıcı Adı"),
          usernameTextField(context),
          divider(),
          textFieldLabel("Parola"),
          passwordTextField(context),
          divider(),
          forgotPasswordField(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              loginButton(context, "Giriş Yap", "0A234A"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 15,
              ),
              addFirmButton(context),
            ],
          ),
        ],
      ),
    ),
  );
}

addFirmButton(BuildContext context) {
  return new Container(
    width: MediaQuery.of(context).size.width / 2.6,
    //margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    alignment: Alignment.center,
    child: new Row(
      children: <Widget>[
        new Expanded(
          child: new FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: HexColor("ff3232"),
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddFirm()));
            },
            child: new Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: Text(
                      "Firma Ekle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Container loginButton(
    BuildContext context, String buttonText, String buttonColor) {
  return new Container(
    width: MediaQuery.of(context).size.width / 2.6,
    //margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    alignment: Alignment.center,
    child: new Row(
      children: <Widget>[
        new Expanded(
          child: new FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: HexColor(buttonColor),
            onPressed: () async {
              await logIn(context)
                  .then((value) async => await alertDialog(value, context));
            },
            child: new Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<bool> alertDialog(String message, BuildContext context) {
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
              Navigator.pop(context);
            },
          )
        ],
      );
    },
    barrierDismissible: true,
  );
}

Future<String> logIn(BuildContext context) async {
  String message;
  if (SharedPref.isFirmAdded() != "none") {
    Map variables = new Map();
    Firm _firm = SharedPref.getFirm();

    variables['dbUsername'] = _firm.username.toString();
    variables['dbPassword'] = _firm.password.toString();
    variables['username'] = usernameController.text.trim();
    variables['password'] = passwordController.text.trim();
    print(variables);

    await Services.httpPost(Urls.login, isJson: false, variables: variables)
        .then((response) async {
      Map responseMap = json.decode(response.body);

      if (responseMap['error'] == false) {
        User _user = User.fromJson(responseMap);

        await SharedPref.addUser(_user).then((value) {
          if (value) {
            message = "Başarılı";
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          } else {
            print("Error! Try Again");
            message = "Error! Try Again!";
          }
        });
      } else {
        print("Please check your internet connection");
        message = responseMap['message'];
      }
    });
  } else {
    print("Önce Firma Ekleyiniz");
    message = "Lütfen Önce Firma Tanımlayınız!";
  }
  return message;
}

Row forgotPasswordField() {
  return new Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: new FlatButton(
          child: new Text(
            "Parolamı unuttum",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: HexColor("0A234A"),
              fontSize: 15.0,
            ),
            textAlign: TextAlign.end,
          ),
          onPressed: () => {},
        ),
      ),
    ],
  );
}

Container passwordTextField(BuildContext context) {
  return new Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.redAccent,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: TextField(
            controller: passwordController,
            obscureText: true,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '*********',
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

Divider divider() {
  return Divider(
    height: 24.0,
  );
}

Container usernameTextField(BuildContext context) {
  return new Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.redAccent,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: TextField(
            controller: usernameController,
            autofocus: true,
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'excalibur',
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

Row textFieldLabel(String label) {
  return new Row(
    children: <Widget>[
      new Expanded(
        child: new Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: new Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    ],
  );
}

Container loginIcon() {
  return Container(
    padding: EdgeInsets.all(60.0),
    child: Center(
      child: Icon(
        Icons.account_circle_sharp,
        color: HexColor("0A234A"),
        size: 50.0,
      ),
    ),
  );
}
