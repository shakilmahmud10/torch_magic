import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {

  final List<Color> baseColors = [
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.blue,
    Colors.indigo,
    Colors.deepPurple,
    Colors.purple,
    Colors.pink,
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.white,
    Colors.grey,
    Colors.brown,
  ];

  int currentIndex = 0;
  double brightness = 1.0;

  void _changeColors (int direction){
    setState(() {
      currentIndex = (currentIndex + direction) % baseColors.length;
      if (currentIndex < 0) {
        currentIndex = currentIndex + baseColors.length;
      }
    });
  }

  void _adjustBrightness (double delta){
    setState(() {
      brightness = (brightness + delta).clamp(0.1, 1.0);
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  //   // Hides the bottom navigation bar and the status bar
  // }

  @override
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode, overlays:[]);
  Widget build(BuildContext context) {

    final Color currentColor = baseColors[currentIndex];
    final Color adjustColor = currentColor.withOpacity(brightness);

    return Scaffold(
      backgroundColor: adjustColor,
      body: GestureDetector(
        onHorizontalDragEnd: (details){
          if (details.primaryVelocity! <0){
            _changeColors(1);   // Swiped left → Next color
            // print('Displayed color now: $currentColor');
          }else if (details.primaryVelocity! >0){
            _changeColors(-1);   // Swiped right → Previous color
          }
        },

        onVerticalDragUpdate: (details){
          if (details.delta.dy < -5 ){
            _adjustBrightness(0.05);    // Swiping up → Increase brightness
          }else if (details.delta.dy > 5){
            _adjustBrightness(-0.05);   // Swiping down → Decrease brightness
          }
        },

        child: const SizedBox.expand(),
      ),
    );
  }
}
