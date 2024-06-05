import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          ElevatedButton(onPressed: () {}, child: const Text("Log In"))
        ],
      ),
    );
  }
}
