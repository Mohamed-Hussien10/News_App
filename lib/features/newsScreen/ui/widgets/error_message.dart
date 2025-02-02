import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Obs there was an error try again later',
      style: TextStyle(
        color: Colors.red,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    );
  }
}
