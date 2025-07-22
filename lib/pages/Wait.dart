import 'dart:async';
import 'package:flutter/material.dart';

class Wait extends StatefulWidget {
  const Wait({super.key});

  @override
  State<Wait> createState() => _WaitState();
}

class _WaitState extends State<Wait> {

  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
  ];

  final bgColor = Colors.black;

  bool showTop = true;

  @override
  void initState (){
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer){
      setState(() {
        showTop = !showTop;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Expanded(
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  color: showTop ? colors[0] : bgColor ,
              )
          ),
          Expanded(
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  color: showTop ? bgColor : colors[1],
              )
          )
        ],
      ),
    );
  }
}
