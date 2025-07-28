import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';


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
      body: Center(
        child: RotatedBox(
            quarterTurns: 1,
              child: Container(
                color: bgColor,
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.height,
                  child: Marquee(
                      blankSpace: 500,
                      velocity: 300,
                      text: displayText,
                      style: TextStyle(
                        color: textColor,
                        fontSize: MediaQuery.of(context).size.width *0.8,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
