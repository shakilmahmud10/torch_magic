import 'package:flutter/material.dart';


class TextDisplayPage extends StatelessWidget {
  final String displayText;
  final Color bgColor;
  final Color textColor;

  const TextDisplayPage({
    super.key,
    required this.displayText,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 200),
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontSize: 40,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
