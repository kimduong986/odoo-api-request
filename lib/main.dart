import 'package:flutter/material.dart';
import 'package:learn_api_request/models/employee.dart';
import 'package:learn_api_request/screens/home_screen.dart';
import 'package:learn_api_request/screens/sign_in_screen.dart';
import 'package:learn_api_request/post_result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SignIn.routeName,
      routes: {
        SignIn.routeName: (context) => SignIn(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Contact> futureContact;

  @override
  void initState() {
    super.initState();
    futureContact = fetchSingleContact(14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Test'),
      ),
      body: Center(
        child: FutureBuilder<Contact>(
          future: futureContact,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data?.contactAddress ?? "Data not found"),
                  ],
                );
              } else if (snapshot.hasError) {
                print("${snapshot.error}");
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
