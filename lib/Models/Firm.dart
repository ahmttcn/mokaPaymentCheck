class Firm {
  String username;
  String password;

  Firm({
    this.username,
    this.password,
  });

  Firm.fromJson(Map json) {
    this.password = json['dbPassword'];
    this.username = json['dbUsername'];
  }
}
