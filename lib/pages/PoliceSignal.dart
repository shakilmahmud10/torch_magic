import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PoliceSignal extends StatefulWidget {
  const PoliceSignal({super.key});

  @override
  State<PoliceSignal> createState() => _PoliceSignalState();
}

class _PoliceSignalState extends State<PoliceSignal> {
  Color _currentColor = Colors.red;
  int _index = 0;
  Timer? _timer;
  late DateTime _lastTap;

  final List<Color> _colors = [
    Colors.red,
    Colors.white,
    Colors.red,
    Colors.white,
    Colors.red,
    Colors.white,
    Colors.blue,
    Colors.white,
    Colors.blue,
    Colors.white,
    Colors.blue,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // Hides the bottom navigation bar and the status bar


    _lastTap = DateTime.now().subtract(Duration(seconds: 2)); // prevent instant back
    _startSignalAnimation();
  }

  void _startSignalAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentColor = _colors[_index % _colors.length];
        _index++;
      });
    });
  }

  void _handleDoubleTap() {
    DateTime now = DateTime.now();
    if (now.difference(_lastTap) < Duration(milliseconds: 1000)) {
      _timer?.cancel();
      Navigator.pop(context); // Back to previous screen
    } else {
      _lastTap = now;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleDoubleTap,
      child: Scaffold(
        backgroundColor: _currentColor,
        body: const SizedBox.expand(), // full screen color
      ),
    );
  }
}
