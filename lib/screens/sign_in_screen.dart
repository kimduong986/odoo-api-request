import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_api_request/models/employee.dart';
import 'package:learn_api_request/models/user.dart';
import 'package:learn_api_request/screens/home_screen.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/login';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late User user;
  late Employee employee;

  final TextEditingController _txtUsername = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();

  Future<User> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.4.158:8069/web/session/authenticate'),
        body: jsonEncode(
          <String, dynamic>{
            "jsonrpc": "2.0",
            "params": {
              "db": "RPC",
              "login": username,
              "password": password,
            }
          },
        ),
        headers: {"content-type": "application/json"},
      );

      if (response.statusCode == 200) {
        // store cookie to shared preferences
        String cookie = response.headers['set-cookie'].toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('cookie', cookie);

        var body = jsonDecode(response.body);
        return User.createUser(body);
      } else {
        return Future.error('Failed to login');
      }
    } catch (e) {
      return Future.error('Failed to login');
    }
  }

  @override
  void dispose() {
    _txtUsername.dispose();
    _txtPassword.dispose();
    super.dispose();
  }

  // getStringValuesSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? stringValue = prefs.getString('cookie');
  //   return stringValue;
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _txtUsername,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    icon: Icon(Icons.account_circle),
                  ),
                ),
                TextFormField(
                  controller: _txtPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.lock),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await login(_txtUsername.text, _txtPassword.text)
                        .then((value) {
                      user = value;
                    });

                    await getEmployeeData(user.uid).then((value) {
                      employee = value;
                    });

                    Navigator.pushReplacementNamed(
                      context,
                      HomeScreen.routeName,
                      arguments: employee,
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
