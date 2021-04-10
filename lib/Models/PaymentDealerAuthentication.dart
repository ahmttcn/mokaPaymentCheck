class PaymentDealerAuthentication {
  String dealerCode;
  String username;
  String password;
  String checkKey;

  PaymentDealerAuthentication({
    this.dealerCode,
    this.username,
    this.password,
    this.checkKey,
  });

  PaymentDealerAuthentication.fromJson(Map json) {
    this.dealerCode = json['DealerCode'];
    this.password = json['Username'];
    this.username = json['Password'];
    this.checkKey = json['CheckKey'];
  }

  Map toMap(PaymentDealerAuthentication paymentDealerAuthentication) {
    Map map = new Map();
    map['DealerCode'] = paymentDealerAuthentication.dealerCode;
    map['Username'] = paymentDealerAuthentication.username;
    map['Password'] = paymentDealerAuthentication.password;
    map['CheckKey'] = paymentDealerAuthentication.checkKey;
    return map;
  }
}
