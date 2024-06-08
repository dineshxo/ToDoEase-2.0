import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoease/config/config.dart';
import 'package:todoease/constants/styles.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Welcome Back !",
                style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Let's continue where you left off.",
                style: TextStyle(
                    color: const Color.fromARGB(255, 97, 97, 97),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                decoration: textFieldDecoration,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: textFieldDecoration.copyWith(hintText: "Password"),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Registration()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.orange[800],
                      )
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {
                  loginUser();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Log in", style: buttonText),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
