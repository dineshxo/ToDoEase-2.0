import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoease/screens/home.dart';
import 'package:todoease/screens/login.dart';

import 'package:todoease/screens/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('token');

  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isTokenValid = token != null && !JwtDecoder.isExpired(token!);
    return MaterialApp(
      title: 'ToDoEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.ralewayTextTheme(), // textTheme
          fontFamily: GoogleFonts.raleway().fontFamily,
          primaryColor: Colors.amber,
          primarySwatch: Colors.amber,
          useMaterial3: true),
      home: isTokenValid ? Home(token: token!) : const Login(),
    );
  }
}
