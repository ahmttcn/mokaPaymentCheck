import 'package:shared_preferences/shared_preferences.dart';
import 'User.dart';

/// This class is made for the store user local data
/// Methods inside class is static. You can call this methods without
/// creating instance of class.

class SharedPref {
  static SharedPreferences _sharedPref;

  static Future init() async {
    if (_sharedPref == null) {
      _sharedPref = await SharedPreferences.getInstance();
    }
  }

  static Future addString(String str) async {
    try {
      await _sharedPref.setString(str.trim(), str);
      print(_sharedPref.getString(str.trim()));
    } catch (e) {
      print(e);
    }
  }

  static addInt(int value) async {
    try {
      await _sharedPref.setInt(value.toString(), value);
    } catch (e) {
      print(e);
    }
  }

  static Future addUser(User user) async {
    print(user.empId);
    print(user.name);
    print(user.authority);

    try {
      await _sharedPref.setInt("empId", user.empId);
      await _sharedPref.setString("name", user.name.toString());
      await _sharedPref.setString("surname", user.surname.toString());
      await _sharedPref.setString("username", user.username.toString());
      await _sharedPref.setString("password", user.password.toString());
      await _sharedPref.setString("email", user.email.toString());
      await _sharedPref.setString("authority", user.authority.toString());
      await _sharedPref.setString("logIn", "loggedIn");
      return true;
    } catch (e) {
      print("Shared Error");
      print(e);
    }
  }

  static getUser() {
    try {
      User user = User(
        empId: _sharedPref.getInt("empId"),
        name: _sharedPref.getString("name"),
        surname: _sharedPref.getString("surname"),
        username: _sharedPref.getString("username"),
        password: _sharedPref.getString("password"),
        email: _sharedPref.getString("email"),
        authority: _sharedPref.getString("authority"),
      );
      return user;
    } catch (e) {
      print(e);
    }
  }

  static Future logOut() async {
    await _sharedPref.setString("logIn", "loggedOut");
    await _sharedPref.clear();
  }

  static deleteUser() async {
    try {
      await _sharedPref.remove("empId");
      await _sharedPref.remove("name");
      await _sharedPref.remove("surname");
      await _sharedPref.remove("username");
      await _sharedPref.remove("password");
      await _sharedPref.remove("email");
      await _sharedPref.remove("authority");
      await _sharedPref.setString("logIn", "loggedOut");
      //await _sharedPref.remove("logIn");
    } catch (e) {
      print(e);
    }
  }

  static getLoggedIn() {
    try {
      return _sharedPref.getString("logIn") ?? "loggedOut";
    } catch (e) {
      print(e);
    }
  }

  static getString(String str) {
    var string;
    try {
      string = _sharedPref.getString(str) ?? "null geldi";
    } catch (e) {
      print(e);
    }
    return string;
  }

  static getInt(String keyValue) {
    try {
      return _sharedPref.getInt(keyValue);
    } catch (e) {
      print(e);
    }
  }

  static clearPref() async {
    return (await _sharedPref.clear() ?? false);
  }
}

final sharedPref = SharedPref();
