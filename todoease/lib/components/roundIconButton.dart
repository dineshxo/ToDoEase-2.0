import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
      {super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      shape: const CircleBorder(),
      elevation: 6.0,
      constraints: const BoxConstraints.tightFor(width: 65.0, height: 65.0),
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      child: Icon(
        icon,
        size: 30,
        color: Colors.orange[800],
      ),
    );
  }
}
