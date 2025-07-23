import 'dart:async';

import 'package:flutter/material.dart';

class DirectionPage extends StatefulWidget {
  const DirectionPage({super.key});

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {

  final List<IconData> arrow = [
    Icons.keyboard_arrow_down_rounded,
    Icons.keyboard_arrow_down_rounded,
    Icons.keyboard_arrow_down_rounded,
  ];

  final List <Color> arrowColor = [
    Colors.white,
    Colors.yellow,
    Colors.yellowAccent,
  ];

  int phase = 0;
  int step = 0;
  List <bool> visible = [false, false, false];
  Timer? timer;


  @override
  void initState() {
    super.initState();
    _startPatternCycle();
  }

  void _startPatternCycle(){
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer){
      setState(() {
        if (phase == 0){
          if (step < 5){
            if (step == 0 ) visible [0] =true;
            if (step == 3 ) visible [1] =true;
            if (step == 5 ) visible [2] =true;
            step ++;
          }
          // phase++;
          // step = 0;

          else{
            phase =1;
            step = 0;
          }
        }

        else if (phase == 1){
          if (step % 2 == 0){
            visible = [false, false, false];
          } else{
            visible = [true, true, true];
          }
          step ++;
          if (step > 5) {
            phase = 2;
            step = 0;
          }
        }

        else if(phase == 2){
          visible = [true, true, true];
          step ++;
          if (step > 5){
            phase = 0;
            step = 0;
            visible = [false, false, false];
          }
        }
      });
    });
  }

  // @override
  // void dispose() {
  //   timer?. cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: List.generate(3, (index) {
          return Expanded(
            child: Center(
              child: Visibility(
                visible: visible[index], // তুমি Timer দিয়ে এটা নিয়ন্ত্রণ করছো
                child: Icon(
                  arrow[index],
                  color: arrowColor[index],    // এটা color list থেকে নিচ্ছো
                  size: MediaQuery.of(context).size.height/2,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
