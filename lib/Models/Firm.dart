class Firm {
  String username;
  String password;
  String serialId;

  Firm({
    this.username,
    this.password,
    this.serialId,
  });

  Firm.fromJson(Map json) {
    this.password = json['dbPassword'];
    this.username = json['dbUsername'];
    this.serialId = json['serialId'];
  }
}
