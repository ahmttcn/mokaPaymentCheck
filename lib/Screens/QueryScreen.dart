import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:payment_check/Models/GetPaymentList.dart';
import 'package:payment_check/Models/MokaPaymentData.dart';
import 'package:payment_check/Models/MokaFirmInfo.dart';
import 'package:payment_check/Models/PaymentDealerAuthentication.dart';
import 'package:payment_check/Models/PaymentDealerRequest.dart';
import 'package:payment_check/Models/PaymentList.dart';
import 'package:payment_check/Models/SharedPref.dart';
import 'package:payment_check/Screens/PaymentDetailScreen.dart';
import 'package:payment_check/Utils/Services.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:payment_check/Utils/Urls.dart';

class QueryScreen extends StatefulWidget {
  QueryScreen({Key key}) : super(key: key);

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen>
    with AutomaticKeepAliveClientMixin<QueryScreen> {
  String startStr = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
  String endStr = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
  List data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: HexColor("1f1f1f"),
      body: Flex(
        direction: Axis.vertical,
        children: [
          designCard(),
          Divider(
            color: Colors.redAccent,
            height: 12,
            endIndent: 10,
            indent: 10,
            thickness: 1,
          ),
          Expanded(
            child: futureBuilder(),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<PaymentList>> futureBuilder() {
    return FutureBuilder(
      future: makeQuery(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("none");
            break;
          case ConnectionState.waiting:
            return Center(
                child: Text(
              "Loading...",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ));
            break;
          default:
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}",
                  style: TextStyle(color: Colors.white, fontSize: 24));
            } else {
              return buildList(context, snapshot);
            }
        }
      },
    );
  }

  Card designCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(25, 25, 25, 5),
      color: HexColor("000005"),
      child: Column(
        children: <Widget>[
          designCardRow(),
          //designQueryButton(),
        ],
      ),
    );
  }

  TextButton designQueryButton() {
    return TextButton(
      onPressed: () async {
        await makeQuery().then((value) {
          print(value[0].cardHolderFullName);
        });
      },
      child: Text(
        "Ödeme Sorgula",
        style: TextStyle(color: Colors.black),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      ),
    );
  }

  Row designCardRow() {
    return Row(
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
                  if (date.hour == 00) {
                    startStr =
                        DateFormat('yyyy-MM-dd 00:mm').format(date).toString();
                  } else {
                    startStr =
                        DateFormat('yyyy-MM-dd kk:mm').format(date).toString();
                  }
                });
                print(startStr);
                print('confirm ' +
                    DateFormat('yyyy-MM-dd kk:mm').format(date).toString());
              },
              currentTime: DateTime.parse(startStr),
              locale: LocaleType.tr,
            );
          },
          child: Text(
            startStr,
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
                  if (date.hour == 00) {
                    endStr =
                        DateFormat('yyyy-MM-dd 00:mm').format(date).toString();
                  } else {
                    endStr =
                        DateFormat('yyyy-MM-dd kk:mm').format(date).toString();
                  }
                });
                print('confirm $date');
              },
              currentTime: DateTime.parse(endStr),
              locale: LocaleType.tr,
            );
          },
          child: Text(
            endStr,
            style: TextStyle(color: Colors.black),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.amberAccent),
          ),
        ),
      ],
    );
  }

  Future<List<PaymentList>> makeQuery() async {
    Map responseMap = new Map();
    List<PaymentList> paymentList = [];
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
    paymentDealerRequest.paymentStartDate = startStr;
    paymentDealerRequest.paymentEndDate = endStr;

    GetPaymentList getPaymentList = new GetPaymentList(
        paymentDealerAuthentication: paymentDealerAuthentication,
        paymentDealerRequest: paymentDealerRequest);
    print(paymentDealerAuthentication.username.toString());
    await Services.httpPost(
      Urls.getPaymentList,
      isJson: true,
      variables: getPaymentList.toJson(),
    ).then((response) async {
      responseMap = json.decode(response.body);
      MokaPaymentData mokaPaymentData = MokaPaymentData.fromJson(responseMap);
      print("MokaPaymentData: ${responseMap['Data'].toString()}");
      for (var i = 0; i < mokaPaymentData.data.listItemCount; i++) {
        PaymentList paymentListObject = mokaPaymentData
            .data.paymentList[mokaPaymentData.data.listItemCount - 1 - i];
        paymentList.add(paymentListObject);
      }
    });
    print("Payment List: ${paymentList.length.toString()}");
    return paymentList;
  }

  Widget buildList(BuildContext context, AsyncSnapshot snapshot) {
    List<PaymentList> _paymentList = snapshot.data;
    print(_paymentList.length);
    return ListView.builder(
      itemCount: _paymentList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, int index) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: HexColor("202020")),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Text(
              '${_paymentList[index].cardHolderFullName}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(
                  Icons.date_range_outlined,
                  color: Colors.amberAccent,
                  size: 20,
                ),
                Text(
                  " " +
                      _paymentList[index].paymentDate.split("T")[0].toString() +
                      " ",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.monetization_on,
                  color: Colors.amberAccent,
                  size: 20,
                ),
                Text(
                  " " + _paymentList[index].amount.toString() + " ",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24),
                ),
              ),
              child: Icon(
                  (_paymentList[index].trxStatus) == 1
                      ? Icons.beenhere_rounded
                      : Icons.warning,
                  color: (_paymentList[index].trxStatus) == 1
                      ? Colors.greenAccent
                      : Colors.redAccent),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PaymentDetail(paymentList: _paymentList[index]),
                  fullscreenDialog: true,
                  maintainState: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
