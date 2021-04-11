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

  Map<String, dynamic> toMap(
          PaymentDealerAuthentication paymentDealerAuthentication) =>
      <String, dynamic>{
        'DealerCode': paymentDealerAuthentication.dealerCode,
        'Username': paymentDealerAuthentication.username,
        'Password': paymentDealerAuthentication.password,
        'CheckKey': paymentDealerAuthentication.checkKey,
      };
}
