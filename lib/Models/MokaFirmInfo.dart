class MokaFirmInfo {
  String dealerCode;
  String username;
  String password;

  MokaFirmInfo({this.username, this.password, this.dealerCode});

  MokaFirmInfo.fromJson(Map json) {
    this.password = json['apiPassword'];
    this.username = json['apiUsername'];
    this.dealerCode = json['dealerCode'];
  }
}
