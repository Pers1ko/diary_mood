import 'package:flutter/material.dart';
import 'screens/mood_diary.dart';
import 'screens/calendar.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    '/': (context) => MoodDiaryPage(),
    '/calendar': (context) => CalendarPage(),
  };
}
