import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todoease/config/config.dart';

class Home extends StatefulWidget {
  final token;

  const Home({super.key, @required this.token});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String email;
  late String userId;
  TextEditingController titleController = TextEditingController();

  void newTodo() async {
    if (titleController.text.isNotEmpty) {
      var reqBody = {
        "userID": userId,
        "title": titleController.text,
        "isDone": false,
      };

      var response = await http.post(Uri.parse(createTodo),
          body: jsonEncode(reqBody),
          headers: {"Content-Type": "application/json"});

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const Login()));
      } else {
        print('Registration unsuccessful.');
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    userId = jwtDecodedToken['_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text(email)),
            FloatingActionButton(
              onPressed: () {
                _displayInputDialog(context);
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _displayInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add new todo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                ),
                ElevatedButton(
                    onPressed: () {
                      newTodo();
                    },
                    child: const Text("Add"))
              ],
            ),
          );
        });
  }
}
