import 'dart:convert';

import 'package:learn_api_request/models/department.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Employee {
  final String userId;
  final String employeeID;
  final String name;
  final String workingPhone;
  final Department department;

  Employee({
    required this.userId,
    required this.employeeID,
    required this.name,
    required this.workingPhone,
    required this.department,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      userId: json['user_id'].toString(),
      employeeID: json['employee_id'].toString(),
      name: json['name'],
      workingPhone: json['working_phone'],
      department: Department.fromJson(json['department']),
    );
  }
}

Future<Employee> getEmployeeData(String userId) async {
  try {
    // print(userId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookie = prefs.getString('cookie');

    String url =
        "http://192.168.4.158:8069/api/employee/get_employee/" + userId;

    final response = await http.get(
      Uri.parse(url),
      // get from shared preferences
      headers: {
        "Cookie": cookie.toString().split(";")[0],
      },
    );

    if (response.statusCode == 200) {
      return Employee.fromJson(jsonDecode(response.body));
    } else {
      throw ("Error ${response.statusCode}");
    }
  } catch (e) {
    return Future.error(e);
  }
}
