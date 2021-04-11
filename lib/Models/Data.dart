import 'package:payment_check/Models/PaymentList.dart';

class Data {
  bool isSuccessful;
  String resultCode;
  String resultMessage;
  int listItemCount;
  List<PaymentList> paymentList;

  Data(
      {this.isSuccessful,
      this.resultCode,
      this.resultMessage,
      this.listItemCount,
      this.paymentList});

  Data.fromJson(Map<String, dynamic> json) {
    isSuccessful = json['IsSuccessful'];
    resultCode = json['ResultCode'];
    resultMessage = json['ResultMessage'];
    listItemCount = json['ListItemCount'];
    if (json['PaymentList'] != null) {
      paymentList = [];
      json['PaymentList'].forEach((v) {
        paymentList.add(new PaymentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccessful'] = this.isSuccessful;
    data['ResultCode'] = this.resultCode;
    data['ResultMessage'] = this.resultMessage;
    data['ListItemCount'] = this.listItemCount;
    if (this.paymentList != null) {
      data['PaymentList'] = this.paymentList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
