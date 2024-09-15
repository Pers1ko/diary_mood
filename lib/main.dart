import 'package:diary_mood/screens/calendar.dart';
import 'package:flutter/material.dart';
import 'package:diary_mood/screens/mood_diary.dart';
import 'package:diary_mood/screens/statistics.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ru', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood Diary',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoodDiaryPage(),
      routes: {
        '/statistics': (context) => StatisticsPage(),
        '/calendar': (context) => CalendarPage(),
      },
    );
  }
}
