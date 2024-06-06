import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoease/components/roundIconButton.dart';
import 'package:todoease/components/roundIconButtonSmall.dart';
import 'package:todoease/components/todoList.dart';
import 'package:todoease/components/welcomeContainer.dart';
import 'dart:convert';

import 'package:todoease/config/config.dart';
import 'package:todoease/screens/login.dart';

class Home extends StatefulWidget {
  final String token;

  const Home({super.key, required this.token});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String email;
  late String userId;
  List? todoItems = [];
  TextEditingController titleController = TextEditingController();

  void newTodo() async {
    if (titleController.text.isNotEmpty) {
      if (userId.isEmpty) {
        print('User ID is not set.');
        return;
      }

      var reqBody = {
        "userId": userId,
        "title": titleController.text,
        "isDone": false,
      };

      print('Request Body: $reqBody');

      var response = await http.post(Uri.parse(createTodo),
          body: jsonEncode(reqBody),
          headers: {"Content-Type": "application/json"});

      var jsonResponse = jsonDecode(response.body);

      print('Response Status: ${jsonResponse['status']}');

      if (jsonResponse['status']) {
        titleController.clear();
        getTodoList(userId);
      } else {
        print('Registration unsuccessful.');
      }
    } else {
      print('Title is empty.');
    }
  }

  void getTodoList(userId) async {
    var reqBody = {
      "userId": userId,
    };

    print('Request Body: $reqBody');

    var response = await http.post(Uri.parse(getTodoData),
        body: jsonEncode(reqBody),
        headers: {"Content-Type": "application/json"});

    var jsonResponse = jsonDecode(response.body);

    print('Response Status: ${jsonResponse['status']}');
    setState(() {
      todoItems = jsonResponse['success'];
    });
    print(todoItems);
  }

  void deleteTodo(id) async {
    var reqBody = {
      "id": id,
    };

    print('Request Body: $reqBody');

    var response = await http.post(Uri.parse(deleteTodoData),
        body: jsonEncode(reqBody),
        headers: {"Content-Type": "application/json"});

    var jsonResponse = jsonDecode(response.body);

    print('Response Status: ${jsonResponse['status']}');

    if (jsonResponse['status']) {
      getTodoList(userId);
    }
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Clear the stored token

    // Navigate back to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'] ?? '';
    userId = jwtDecodedToken['_id'] ?? '';

    print('Email: $email');
    print('User ID: $userId');
    getTodoList(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu_sharp,
          size: 30,
        ),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 30,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: WelcomeContainer(
              userName: email,
            ),
          ),
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.amber),
                    child: ToDoList(
                      todoItems: todoItems ?? [],
                      deleteTodo: deleteTodo,
                    )),
                Align(
                  alignment: const FractionalOffset(0.5, 1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: RoundIconButton(
                        icon: Icons.add,
                        onPressed: () {
                          _displayInputDialog(context);
                        }),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _displayInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Add Task',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLength: 40,
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: 'Enter New Task Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundIconButtonSmall(
                        color: Colors.green,
                        icon: Icons.check,
                        onPressed: () {
                          newTodo();

                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RoundIconButtonSmall(
                        color: Colors.red,
                        icon: Icons.close,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
