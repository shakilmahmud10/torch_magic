import 'package:flutter/material.dart';
import 'package:torch_magic/pages/TextDisplayPage.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {

  final TextEditingController _controller = TextEditingController();
  Color? selectedBgColor;
  Color? selectedTextColor;
  String? displayText;

  final List<Color> bgColors = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
  ];
  final List<Color> textColors = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
  ];

  void goToDisplayPage (){
    if (_controller.text.isNotEmpty && selectedBgColor != null && selectedTextColor != null){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TextDisplayPage(
              displayText : _controller.text,
              bgColor : selectedBgColor!,
              textColor : selectedTextColor!
          ),
        ),
      );
    } else {
      return;
    }

  }


  Widget buildColorSelector(String label, List<Color> colors, Color? selected, Function(Color)onSelect){
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: colors.map(
              (Color) => GestureDetector(
                onTap: () => setState(() => onSelect(Color)),
                child: CircleAvatar(
                  backgroundColor: Color,
                  radius: 20,
                  child: selected == Color? const Icon(Icons.check, color: Colors.white): null,
                ),
              )
          )
           .toList(),
        )
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 20),
            buildColorSelector("Background Color", bgColors, selectedBgColor, (c) => selectedBgColor = c),
            SizedBox(height: 20),
            buildColorSelector("Text Color", textColors, selectedTextColor, (c) => selectedTextColor = c),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                  onPressed: goToDisplayPage,
                  child: Text("Display"),
              ),
            )

          ],
        ),
      ),
    );
  }
}
