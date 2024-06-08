import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoease/components/roundIconButtonSmall.dart';
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

      try {
        var response = await http.post(
          Uri.parse(login),
          body: jsonEncode(reqBody),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status']) {
            var jwtToken = jsonResponse['token'];
            prefs.setString('token', jwtToken);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(token: jwtToken),
              ),
            );
          } else {
            showErrorDialog(jsonResponse['message']);
          }
        } else {
          var jsonResponse = jsonDecode(response.body);
          showErrorDialog(jsonResponse['message']);
        }
      } catch (e) {
        showErrorDialog(e.toString());
      }
    } else {
      showErrorDialog("Email and Password cannot be empty");
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Error",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: [
            RoundIconButtonSmall(
              color: Colors.red,
              icon: Icons.check,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 450,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome Back !",
                          style: TextStyle(
                            color: Color(0xff61376b),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                            height: 10), // Add some space between the texts
                        Text(
                          "Let's continue where you left off.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 92, 92, 92),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
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
                    decoration:
                        textFieldDecoration.copyWith(hintText: "Password"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
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
              height: 10,
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
    );
  }
}
