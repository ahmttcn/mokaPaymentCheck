import 'package:payment_check/Models/PaymentDealerAuthentication.dart';
import 'package:payment_check/Models/PaymentDealerRequest.dart';

class GetPaymentList {
  PaymentDealerAuthentication paymentDealerAuthentication;
  PaymentDealerRequest paymentDealerRequest;

  GetPaymentList({this.paymentDealerAuthentication, this.paymentDealerRequest});

  GetPaymentList.fromJson(Map<String, dynamic> json) {
    paymentDealerAuthentication = json['PaymentDealerAuthentication'] != null
        ? new PaymentDealerAuthentication.fromJson(
            json['PaymentDealerAuthentication'])
        : null;
    paymentDealerRequest = json['PaymentDealerRequest'] != null
        ? new PaymentDealerRequest.fromMap(json['PaymentDealerRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentDealerAuthentication != null) {
      data['PaymentDealerAuthentication'] =
          this.paymentDealerAuthentication.toMap(paymentDealerAuthentication);
    }
    if (this.paymentDealerRequest != null) {
      data['PaymentDealerRequest'] =
          this.paymentDealerRequest.toMap(paymentDealerRequest);
    }
    return data;
  }
}
