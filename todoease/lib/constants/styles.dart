import 'package:flutter/material.dart';

InputDecoration textFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Color.fromARGB(255, 134, 134, 134)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50.0),
    borderSide: const BorderSide(color: Colors.orange, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50.0),
    borderSide: BorderSide(color: Colors.orange, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50.0),
    borderSide: const BorderSide(color: Colors.red, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50.0),
    borderSide: const BorderSide(color: Colors.red, width: 2),
  ),
);

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange[800], // text color
    padding:
        const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // rounded corners
    ),
    textStyle: const TextStyle(
      fontSize: 18, // font size
      fontWeight: FontWeight.bold, // font weight
    ));

const TextStyle buttonText =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
