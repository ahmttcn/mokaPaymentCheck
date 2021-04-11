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

  Map<String, dynamic> toMap(PaymentDealerRequest paymentDealerRequest) =>
      <String, dynamic>{
        'PaymentStartDate': paymentDealerRequest.paymentStartDate,
        'PaymentEndDate': paymentDealerRequest.paymentEndDate,
        'PaymentStatus': paymentDealerRequest.paymentStatus,
        'TrxStatus': paymentDealerRequest.trxStatus,
      };
}
