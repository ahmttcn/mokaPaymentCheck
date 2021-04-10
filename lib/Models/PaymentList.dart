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

  PaymentList({
    this.dealerPaymentId,
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
    this.trxStatus,
  });

  PaymentList.fromJson(Map json) {
    this.dealerPaymentId = json['DealerPaymentId'];
    this.otherTrxCode = json['OtherTrxCode'];
    this.cardHolderFullName = json['CardHolderFullName'];
    this.cardNumberFirstSix = json['CardNumberFirstSix'];
    this.cardNumberLastFour = json['CardNumberLastFour'];
    this.paymentDate = json['PaymentDate'];
    this.amount = json['Amount'];
    this.currencyCode = json['CurrencyCode'];
    this.installmentNumber = json['InstallmentNumber'];
    this.dealerCommissionAmount = json['DealerCommissionAmount'];
    this.isThreeD = json['IsThreeD'];
    this.paymentStatus = json['PaymentStatus'];
    this.trxStatus = json['TrxStatus'];
  }
}
