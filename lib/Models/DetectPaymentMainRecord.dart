String detectPayment(int paymentStatus) {
  String message;
  switch (paymentStatus) {
    case 0:
      message = "Beklemede";
      break;
    case 1:
      message = "Ön Provizyon";
      break;
    case 2:
      message = "Ödeme";
      break;
    case 3:
      message = "İptal";
      break;
    case 4:
      message = "Tam İade";
      break;
    default:
      message = "Undefined PaymentStatus";
  }
  return message;
}

String detectTrx(int trxStatus) {
  String message;
  switch (trxStatus) {
    case 0:
      message = "Beklemede";
      break;
    case 1:
      message = "Başarılı";
      break;
    case 2:
      message = "Başarısız";
      break;
    default:
      message = "Undefined Trx";
  }
  return message;
}
