import 'package:payment_check/Models/Data.dart';

class MokaPaymentData {
  Data data;
  String resultCode;
  String resultMessage;
  Null exception;

  MokaPaymentData(
      {this.data, this.resultCode, this.resultMessage, this.exception});

  MokaPaymentData.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    resultCode = json['ResultCode'];
    resultMessage = json['ResultMessage'];
    exception = json['Exception'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    data['ResultCode'] = this.resultCode;
    data['ResultMessage'] = this.resultMessage;
    data['Exception'] = this.exception;
    return data;
  }
}
