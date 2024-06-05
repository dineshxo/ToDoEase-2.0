import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoease/config/config.dart';
import 'dart:convert';

import 'package:todoease/screens/home.dart';
import 'package:todoease/screens/registration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(Uri.parse(login),
          body: jsonEncode(reqBody),
          headers: {"Content-Type": "application/json"});

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        var jwtToken = jsonResponse['token'];
        prefs.setString('token', jwtToken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      token: jwtToken,
                    )));
      } else {
        print('Login unsuccessful.');
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "email"),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: "password"),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Registration()));
              },
              child: const Text("Already have an Account")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: const Text("Log In"))
        ],
      ),
    );
  }
}
