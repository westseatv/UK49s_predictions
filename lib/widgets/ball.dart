import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final int number;
  final Color? color;
  final bool small;
  const Ball({
    Key? key,
    required this.number,
    this.color,
    this.small = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 2),
      padding: small ? null : const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Text(
          number < 10 ? '0$number' : '$number',
          style: const TextStyle(
            fontFamily: 'Tohama',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
