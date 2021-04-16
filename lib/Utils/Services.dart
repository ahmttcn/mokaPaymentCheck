import 'dart:convert';

import 'package:http/http.dart' as http;

class Services {
  static const ROOT = 'http://localhost/EmployeesDB/employee_actions.php';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  static Future<http.Response> httpPost(String url,
      {bool isJson, Map variables, Map<String, String> headers}) async {
    try {
      final response = await http.post(url,
          headers: (isJson)
              ? {
                  "content-type": "application/json",
                  "accept": "application/json",
                }
              : {"content-type": "application/x-www-form-urlencoded"},
          body: (isJson) ? json.encode(variables) : variables);
      print('Login Response: ${response.body}');

      if (200 == response.statusCode) {
        return response;
      } else {
        print(response.statusCode.toString());
        return http.Response("emptybody", 400);
      }
    } catch (e) {
      print(e.toString());
      return http.Response(
          "emptybody", 400); // return an empty list on exception/error
    }
  }

  // Method to add employee to the database...
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateEmployee(
      String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print('deleteEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
