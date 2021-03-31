class User {
  int empId;
  String name;
  String surname;
  String username;
  String password;
  String email;
  String authority;

  User(
      {this.empId,
      this.name,
      this.surname,
      this.username,
      this.password,
      this.email,
      this.authority});

  User.fromJson(Map json) {
    this.empId = json['empId'];
    this.name = json['name'];
    this.surname = json['surname'];
    this.password = json['password'];
    this.username = json['username'];
    this.email = json['email'];
    this.authority = json['authority'];
  }
}
