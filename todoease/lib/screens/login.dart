import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoease/config/config.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerUser() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var resBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(Uri.parse(registration),
          body: jsonEncode(resBody),
          headers: {"Content-Type": "application/json"});

      print(response);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
          ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: const Text("Register"))
        ],
      ),
    );
  }
}
