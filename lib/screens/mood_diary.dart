import 'package:diary_mood/screens/statistics.dart';
import 'package:flutter/material.dart';
import 'package:diary_mood/screens/widgets/custom_button.dart';
import 'package:diary_mood/screens/widgets/mood_selector.dart';
import 'package:diary_mood/screens/widgets/sliders.dart';
import 'package:diary_mood/screens/widgets/toggle.dart';
import 'package:diary_mood/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MoodDiaryPage extends StatefulWidget {
  @override
  _MoodDiaryPageState createState() => _MoodDiaryPageState();
}

class _MoodDiaryPageState extends State<MoodDiaryPage> {
  List<String> selectedMoods = [];
  double stressLevel = 0;
  double confidenceLevel = 0;
  String note = '';
  int _selectedIndex = 0;

  bool get isFormValid {
    return selectedMoods.isNotEmpty &&
        stressLevel > 0 &&
        confidenceLevel > 0 &&
        note.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM HH:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 41, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    formattedDate,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    'images/calendar_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/calendar');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MoodToggleWithText(
            onToggle: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: _selectedIndex == 0
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Что чувствуешь?',
                            style: AppTextStyles.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          MoodSelector(
                            onMoodsSelected: (moods) {
                              setState(() {
                                selectedMoods = moods;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Text('Уровень стресса',
                              style: AppTextStyles.titleMedium),
                          StressLevelSlider(
                            onChanged: (value) {
                              setState(() {
                                stressLevel = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Text('Самооценка', style: AppTextStyles.titleMedium),
                          ConfidenceLevelSlider(
                            onChanged: (value) {
                              setState(() {
                                confidenceLevel = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Text('Заметки', style: AppTextStyles.titleMedium),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 0.1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Theme(
                              data: ThemeData(
                                textSelectionTheme: TextSelectionThemeData(
                                  cursorColor: Colors.black,
                                  selectionColor: Colors.black.withOpacity(0.3),
                                  selectionHandleColor: Colors.black,
                                ),
                              ),
                              child: TextField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  hintText: 'Введите заметку',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                maxLines: 3,
                                style: TextStyle(
                                  color:
                                      note.isEmpty ? Colors.grey : Colors.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    note = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            onPressed: isFormValid
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Ответ сохранен'),
                                          content: const Text(
                                              'Ваша информация была успешно сохранена.'),
                                          actions: [
                                            Center(
                                              child: TextButton(
                                                child: const Text('ОК',
                                                    style: TextStyle(
                                                        color: Colors.orange)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                : null,
                            label: 'Сохранить',
                            isActive: isFormValid,
                          ),
                        ],
                      ),
                    ),
                  )
                : StatisticsPage(),
          ),
        ],
      ),
    );
  }
}
