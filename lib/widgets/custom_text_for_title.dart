import 'package:flutter/material.dart';

class CustomTextForTitle extends StatelessWidget {
  const CustomTextForTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'CogHealth',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
