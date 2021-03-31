import 'package:http/http.dart' as http;

class PaymentApi {
  static Future getPayments() {
    return http
        .get("http://localhost/webServicePHP/cavusogluPaymentService.php?");
  }
}
