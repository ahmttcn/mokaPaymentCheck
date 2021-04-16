import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:payment_check/Models/DetectPaymentMainRecord.dart';
import 'package:payment_check/Models/PaymentList.dart';

class PaymentDetail extends StatefulWidget {
  final PaymentList paymentList;
  PaymentDetail({Key key, @required this.paymentList}) : super(key: key);

  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

PaymentList _paymentList;
String paymentStatus, trxStatus;

class _PaymentDetailState extends State<PaymentDetail>
    with AutomaticKeepAliveClientMixin<PaymentDetail> {
  @override
  void initState() {
    super.initState();
    _paymentList = widget.paymentList;

    paymentStatus = detectPayment(_paymentList.paymentStatus);
    trxStatus = detectTrx(_paymentList.trxStatus);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ödeme Detayı"),
        centerTitle: true,
        backgroundColor: HexColor("1f1f1f"),
      ),
      backgroundColor: HexColor("262626"),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Card(
              borderOnForeground: true,
              color: HexColor("1f1f1f"),
              child: Center(
                child: Column(
                  children: <Widget>[
                    sizedBox(),
                    Text(
                      _paymentList.cardHolderFullName,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: (widget.paymentList.trxStatus == 1)
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    sizedBox(),
                    notifyText(
                        "Ödeme Durumu: " + paymentStatus + " " + trxStatus),
                    sizedBox(),
                    notifyText("Bayi Ödeme No: " +
                        _paymentList.dealerPaymentId.toString()),
                    sizedBox(),
                    notifyText("İşlem Tarihi: " +
                        _paymentList.paymentDate.split("T").first +
                        "  " +
                        _paymentList.paymentDate.split("T").last),
                    sizedBox(),
                    notifyText("Miktar: " +
                        _paymentList.amount.toString() +
                        " " +
                        _paymentList.currencyCode),
                    sizedBox(),
                    notifyText("Bayi Komisyon Miktarı: " +
                        _paymentList.dealerCommissionAmount.toString() +
                        " " +
                        _paymentList.currencyCode),
                    sizedBox(),
                    notifyText(
                        "3D: " + ((_paymentList.isThreeD) ? "Evet" : "Hayır")),
                    sizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox sizedBox() {
    return SizedBox(
      height: 10,
    );
  }

  Row notifyText(String text) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
