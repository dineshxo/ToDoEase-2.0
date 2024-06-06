import 'package:flutter/material.dart';

class WelcomeContainer extends StatelessWidget {
  final String userName;
  WelcomeContainer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello!',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold),
              ),
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              'assets/images/dp.png',
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
