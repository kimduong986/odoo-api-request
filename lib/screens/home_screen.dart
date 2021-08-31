import 'package:flutter/material.dart';
import 'package:learn_api_request/models/employee.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    late final Employee employee =
        ModalRoute.of(context)!.settings.arguments as Employee;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('User ID: ${employee.userId}'),
              SizedBox(
                height: 10,
              ),
              Text('Employee ID ${employee.employeeID}'),
              SizedBox(
                height: 10,
              ),
              Text('Name ${employee.name}'),
              SizedBox(
                height: 10,
              ),
              Text('Department ${employee.department.name}'),
            ],
          ),
        ),
      ),
    );
  }
}
