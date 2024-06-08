import 'package:flutter/material.dart';

class RoundIconButtonSmall extends StatelessWidget {
  const RoundIconButtonSmall(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.color});

  final IconData icon;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      shape: const CircleBorder(),
      elevation: 5,
      constraints: const BoxConstraints.tightFor(width: 50.0, height: 50.0),
      fillColor: color,
      child: Icon(
        icon,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
