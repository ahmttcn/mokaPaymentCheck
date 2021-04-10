class User {
  int empId;
  String name;
  String surname;
  String username;
  String password;
  String email;
  String posIzin;
  String smsIzin;
  String city;
  String state;
  String address;
  String phoneNumber;

  User(
      {this.empId,
      this.name,
      this.surname,
      this.username,
      this.password,
      this.email,
      this.posIzin,
      this.smsIzin,
      this.city,
      this.state,
      this.address,
      this.phoneNumber});

  User.fromJson(Map json) {
    this.empId = json['empId'];
    this.name = json['name'];
    this.surname = json['surname'];
    this.password = json['password'];
    this.username = json['username'];
    this.email = json['email'];
    this.posIzin = json['posIzin'];
    this.smsIzin = json['smsIzin'];
    this.city = json['city'];
    this.state = json['state'];
    this.address = json['address'];
    this.phoneNumber = json['phoneNumber'];
  }
}
