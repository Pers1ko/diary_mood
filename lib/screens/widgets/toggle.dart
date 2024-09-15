import 'package:flutter/material.dart';
import 'package:animated_button_bar/animated_button_bar.dart';

class MoodToggleWithText extends StatefulWidget {
  final ValueChanged<int> onToggle;

  MoodToggleWithText({required this.onToggle});

  @override
  _MoodToggleWithTextState createState() => _MoodToggleWithTextState();
}

class _MoodToggleWithTextState extends State<MoodToggleWithText> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedButtonBar(
        radius: 34.0,
        padding: const EdgeInsets.only(top: 5, left: 22, right: 22),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        foregroundColor: Colors.orange,
        elevation: 2,
        innerVerticalPadding: 16,
        children: [
          ButtonBarEntry(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
                widget.onToggle(_selectedIndex);
              });
            },
            child: SizedBox(
              width: 300,
              height: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/diary_icons.png',
                    width: 10,
                    height: 10,
                    color: _selectedIndex == 0 ? Colors.white : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Дневник настроения',
                    style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          ButtonBarEntry(
            onTap: () {
              setState(() {
                _selectedIndex = 1;
                widget.onToggle(_selectedIndex);
              });
            },
            child: SizedBox(
              width: 288,
              height: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/Group.png',
                    width: 10,
                    height: 10,
                    color: _selectedIndex == 1 ? Colors.white : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Статистика',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
