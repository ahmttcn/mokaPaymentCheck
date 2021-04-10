class PaymentDealerRequest {
  String paymentStartDate;
  String paymentEndDate;
  int paymentStatus;
  int trxStatus;

  PaymentDealerRequest({
    this.paymentStartDate,
    this.paymentEndDate,
    this.paymentStatus,
    this.trxStatus,
  });

  PaymentDealerRequest.fromMap(Map json) {
    this.paymentStartDate = json['PaymentStartDate'];
    this.paymentEndDate = json['PaymentEndDate'];
    this.paymentStatus = json['PaymentStatus'];
    this.trxStatus = json['TrxStatus'];
  }

  Map toMap(PaymentDealerRequest paymentDealerRequest) {
    Map map = new Map();
    map['PaymentStartDate'] = paymentDealerRequest.paymentStartDate;
    map['PaymentEndDate'] = paymentDealerRequest.paymentEndDate;
    map['PaymentStatus'] = paymentDealerRequest.paymentStatus;
    map['TrxStatus'] = paymentDealerRequest.trxStatus;
    return map;
  }
}
