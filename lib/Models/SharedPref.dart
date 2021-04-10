import 'package:payment_check/Models/MokaFirmInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Firm.dart';
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
    print(user.posIzin);
    print(user.smsIzin);
    print(user.address);

    try {
      await _sharedPref.setInt("empId", user.empId);
      await _sharedPref.setString("name", user.name.toString());
      await _sharedPref.setString("surname", user.surname.toString());
      await _sharedPref.setString("username", user.username.toString());
      await _sharedPref.setString("password", user.password.toString());
      await _sharedPref.setString("email", user.email.toString());
      await _sharedPref.setString("posIzin", user.posIzin.toString());
      await _sharedPref.setString("smsIzin", user.smsIzin.toString());
      await _sharedPref.setString("city", user.city.toString());
      await _sharedPref.setString("state", user.state.toString());
      await _sharedPref.setString("address", user.address.toString());
      await _sharedPref.setString("phoneNumber", user.phoneNumber.toString());
      await _sharedPref.setString("logIn", "loggedIn");
      return true;
    } catch (e) {
      print("Shared Error");
      print(e);
    }
  }

  static Future addFirm(Firm firm) async {
    try {
      await _sharedPref.setString("firmUsername", firm.username.toString());
      await _sharedPref.setString("firmPassword", firm.password.toString());
      await _sharedPref.setString("firmSerialId", firm.serialId.toString());
      await _sharedPref.setString("firm", "added");
      return true;
    } catch (e) {
      print("Shared Error");
      print(e);
    }
  }

  static getFirm() {
    try {
      Firm firm = Firm(
        username: _sharedPref.getString("firmUsername"),
        password: _sharedPref.getString("firmPassword"),
        serialId: _sharedPref.getString("firmSerialId"),
      );
      return firm;
    } catch (e) {
      print(e);
    }
  }

  static deleteFirm() async {
    try {
      await _sharedPref.remove("firmUsername");
      await _sharedPref.remove("firmPassword");
      await _sharedPref.remove("firmSerialId");
    } catch (e) {
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
          posIzin: _sharedPref.getString("posIzin"),
          smsIzin: _sharedPref.getString("smsIzin"),
          city: _sharedPref.getString("city"),
          state: _sharedPref.getString("state"),
          address: _sharedPref.getString("address"),
          phoneNumber: _sharedPref.getString("phoneNumber"));
      return user;
    } catch (e) {
      print(e);
    }
  }

  static Future logOut() async {
    return await _sharedPref.setString("logIn", "loggedOut");
  }

  static deleteUser() async {
    try {
      await _sharedPref.remove("empId");
      await _sharedPref.remove("name");
      await _sharedPref.remove("surname");
      await _sharedPref.remove("username");
      await _sharedPref.remove("password");
      await _sharedPref.remove("email");
      await _sharedPref.remove("posIzin");
      await _sharedPref.remove("smsIzin");
      await _sharedPref.remove("city");
      await _sharedPref.remove("state");
      await _sharedPref.remove("address");
      await _sharedPref.remove("phoneNumber");
      await _sharedPref.setString("logIn", "loggedOut");
      //await _sharedPref.remove("logIn");
    } catch (e) {
      print(e);
    }
  }

  static Future addMoka(MokaFirmInfo firm) async {
    try {
      await _sharedPref.setString("mokaUsername", firm.username.toString());
      await _sharedPref.setString("mokaPassword", firm.password.toString());
      await _sharedPref.setString("mokaDealerCode", firm.dealerCode.toString());
      await _sharedPref.setString("moka", "added");
      return true;
    } catch (e) {
      print("Shared Error");
      print(e);
    }
  }

  static getMoka() {
    try {
      MokaFirmInfo firm = MokaFirmInfo(
        username: _sharedPref.getString("mokaUsername"),
        password: _sharedPref.getString("mokaPassword"),
        dealerCode: _sharedPref.getString("mokaDealerCode"),
      );
      return firm;
    } catch (e) {
      print(e);
    }
  }

  static deleteMoka() async {
    try {
      await _sharedPref.remove("mokaUsername");
      await _sharedPref.remove("mokaPassword");
      await _sharedPref.remove("mokaDealerCode");
      await _sharedPref.remove("moka");
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

  static isFirmAdded() {
    try {
      return _sharedPref.getString("firm") ?? "none";
    } catch (e) {
      print(e);
    }
  }

  static isMokaAdded() {
    try {
      return _sharedPref.getString("moka") ?? "none";
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
