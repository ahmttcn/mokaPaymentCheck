import 'package:payment_check/Models/Data.dart';

class MokaData {
  Data data;
  String resultCode;
  String resultMessage;

  MokaData({
    this.data,
    this.resultCode,
    this.resultMessage,
  });

  MokaData.fromJson(Map json) {
    this.data = json['Data'];
    this.resultCode = json['ResultCode'];
    this.resultMessage = json['ResultMessage'];
  }
}
