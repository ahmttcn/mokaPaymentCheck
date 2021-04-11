class PaymentList {
  int dealerPaymentId;
  String otherTrxCode;
  String cardHolderFullName;
  String cardNumberFirstSix;
  String cardNumberLastFour;
  String paymentDate;
  double amount;
  String currencyCode;
  int installmentNumber;
  double dealerCommissionAmount;
  bool isThreeD;
  int paymentStatus;
  int trxStatus;

  PaymentList(
      {this.dealerPaymentId,
      this.otherTrxCode,
      this.cardHolderFullName,
      this.cardNumberFirstSix,
      this.cardNumberLastFour,
      this.paymentDate,
      this.amount,
      this.currencyCode,
      this.installmentNumber,
      this.dealerCommissionAmount,
      this.isThreeD,
      this.paymentStatus,
      this.trxStatus});

  PaymentList.fromJson(Map<String, dynamic> json) {
    dealerPaymentId = json['DealerPaymentId'];
    otherTrxCode = json['OtherTrxCode'];
    cardHolderFullName = json['CardHolderFullName'];
    cardNumberFirstSix = json['CardNumberFirstSix'];
    cardNumberLastFour = json['CardNumberLastFour'];
    paymentDate = json['PaymentDate'];
    amount = json['Amount'];
    currencyCode = json['CurrencyCode'];
    installmentNumber = json['InstallmentNumber'];
    dealerCommissionAmount = json['DealerCommissionAmount'];
    isThreeD = json['IsThreeD'];
    paymentStatus = json['PaymentStatus'];
    trxStatus = json['TrxStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DealerPaymentId'] = this.dealerPaymentId;
    data['OtherTrxCode'] = this.otherTrxCode;
    data['CardHolderFullName'] = this.cardHolderFullName;
    data['CardNumberFirstSix'] = this.cardNumberFirstSix;
    data['CardNumberLastFour'] = this.cardNumberLastFour;
    data['PaymentDate'] = this.paymentDate;
    data['Amount'] = this.amount;
    data['CurrencyCode'] = this.currencyCode;
    data['InstallmentNumber'] = this.installmentNumber;
    data['DealerCommissionAmount'] = this.dealerCommissionAmount;
    data['IsThreeD'] = this.isThreeD;
    data['PaymentStatus'] = this.paymentStatus;
    data['TrxStatus'] = this.trxStatus;
    return data;
  }
}
