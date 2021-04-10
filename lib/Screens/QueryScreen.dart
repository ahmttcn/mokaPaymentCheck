import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:payment_check/Models/MokaFirmInfo.dart';
import 'package:payment_check/Models/PaymentDealerAuthentication.dart';
import 'package:payment_check/Models/PaymentDealerRequest.dart';
import 'package:payment_check/Models/SharedPref.dart';
import 'package:payment_check/Utils/Services.dart';
import 'package:crypto/crypto.dart';

class QueryScreen extends StatefulWidget {
  QueryScreen({Key key}) : super(key: key);

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  DateTime startDate, endDate;
  String startText = DateTime.now().day.toString() +
          "/" +
          DateTime.now().month.toString() +
          "/" +
          DateTime.now().year.toString() +
          " " +
          DateTime.now().hour.toString() +
          ":" +
          DateTime.now().minute.toString(),
      endText = DateTime.now().day.toString() +
          "/" +
          DateTime.now().month.toString() +
          "/" +
          DateTime.now().year.toString() +
          " " +
          DateTime.now().hour.toString() +
          ":" +
          DateTime.now().minute.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("262626"),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(25),
            color: HexColor("000005"),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          },
                          onConfirm: (date) {
                            setState(() {
                              startText = date.day.toString() +
                                  "/" +
                                  date.month.toString() +
                                  "/" +
                                  date.year.toString() +
                                  " " +
                                  date.hour.toString() +
                                  ":" +
                                  date.minute.toString();
                            });
                            print('confirm $date');
                            startDate = date;
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.tr,
                        );
                      },
                      child: Text(
                        startText,
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          },
                          onConfirm: (date) {
                            setState(() {
                              endText = date.day.toString() +
                                  "/" +
                                  date.month.toString() +
                                  "/" +
                                  date.year.toString() +
                                  " " +
                                  date.hour.toString() +
                                  ":" +
                                  date.minute.toString();
                            });
                            print('confirm $date');
                            startDate = date;
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.tr,
                        );
                      },
                      child: Text(
                        endText,
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.amberAccent),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    await makeQuery();
                  },
                  child: Text(
                    "Ödeme Sorgula",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> makeQuery() async {
    MokaFirmInfo mokaFirmInfo = SharedPref.getMoka();
    PaymentDealerAuthentication paymentDealerAuthentication =
        new PaymentDealerAuthentication();
    PaymentDealerRequest paymentDealerRequest = new PaymentDealerRequest();

    paymentDealerAuthentication.dealerCode = mokaFirmInfo.dealerCode;
    paymentDealerAuthentication.username = mokaFirmInfo.username;
    paymentDealerAuthentication.password = mokaFirmInfo.password;
    var bytes = utf8.encode(mokaFirmInfo.dealerCode +
        'MK' +
        mokaFirmInfo.username +
        'PD' +
        mokaFirmInfo.password);
    paymentDealerAuthentication.checkKey = sha256.convert(bytes).toString();
    paymentDealerRequest.paymentStartDate = '2020-03-01 09:00';
    paymentDealerRequest.paymentEndDate = '2021-04-10 09:00';
    paymentDealerRequest.paymentStatus = 1;
    paymentDealerRequest.trxStatus = 1;
    Map example = new Map();
    example['PaymentDealerAuthentication'] =
        PaymentDealerAuthentication().toMap(paymentDealerAuthentication);
    example['PaymentDealerRequest'] =
        PaymentDealerRequest().toMap(paymentDealerRequest);
    print(example.toString());
    await Services.httpPost(
            'https://service.moka.com/PaymentDealer/GetPaymentList',
            variables: example)
        .then((response) async {
      Map responseMap = json.decode(response.body);
      print(responseMap.toString());
    });
    return "dasd";
  }
}
