class MokaFirmInfo {
  String dealerCode;
  String username;
  String password;
  String typeId;
  String record;

  MokaFirmInfo(
      {this.username,
      this.password,
      this.dealerCode,
      this.typeId,
      this.record});

  MokaFirmInfo.fromJson(Map json) {
    this.password = json['apiPassword'];
    this.username = json['apiUsername'];
    this.dealerCode = json['dealerCode'];
    this.typeId = json['apiTypeId'];
    this.record = json['apiRecord'];
  }
}
