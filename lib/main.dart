import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'constants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EzeRx log in',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Log in'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isObscure = true;
  bool value = false;
  String requestResponse = "erew";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/sign_in.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text("Welcome Back To",
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
              ),
              SizedBox(
                  height: 55,
                  width: 55,
                  child: Image.asset('images/ezerx_logo.png')),
              const SizedBox(
                height: 60.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                onChanged: (value) {},
                decoration: textFieldDecoration.copyWith(
                  hintText: 'Username',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: _isObscure,
                textAlign: TextAlign.start,
                onChanged: (value) {},
                decoration: textFieldDecoration.copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    hintText: 'Password'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CheckboxListTile(
                      title: const Text(
                        "Remember Me",
                        style: TextStyle(fontSize: 10),
                      ),
                      value: value,
                      onChanged: (newValue) {
                        setState(() {
                          value = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 10),
                    ),
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
              Material(
                color: Colors.red[900],
                borderRadius: BorderRadius.circular(15.0),
                elevation: 5.0,
                child: MaterialButton(
                  height: 42.0,
                  onPressed: () async {
                    await requestLogin();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(requestResponse),
                    ));
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> requestLogin() async {
    final headers = {'key': 'gZ8qaqBbCd9&j]p@GD:u=z#]99Ktiyr@#rCNoM{27xIS\$Yli2*yn2ZeS8}bBp99P'};
    var requestBody = {
      "macid": "dc:a6:32:76:0b:ce",
      "username": "test.joy@ezerx.in",
      "pass": "123456"
    };

    final response = await http.post(
      Uri.parse(
          'https://15.206.171.40/login'),
      headers: headers,
      body: requestBody,
    );

    requestResponse = response.body;
  }
}
