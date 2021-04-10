import 'package:payment_check/Models/PaymentList.dart';

class Data {
  bool isSuccessful;
  String resultCode;
  String resultMessage;
  int listItemCount;
  PaymentList paymentList;

  Data({
    this.isSuccessful,
    this.resultCode,
    this.resultMessage,
    this.listItemCount,
    this.paymentList,
  });

  Data.fromJson(Map json) {
    this.isSuccessful = json['IsSuccessful'];
    this.resultCode = json['ResultCode'];
    this.resultMessage = json['ResultMessage'];
    this.listItemCount = json['ListItemCount'];
    this.paymentList = json['PaymentList'];
  }
}
