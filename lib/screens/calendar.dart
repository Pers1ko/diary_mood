import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late ScrollController _scrollController;
  bool _showFullYear = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentMonth();
    });
  }

  void _scrollToCurrentMonth() {
    if (!_showFullYear) {
      double monthHeight = 850.0;
      int currentMonth = _currentDate.month - 1;
      double scrollPosition = monthHeight * (currentMonth ~/ 2);

      _scrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildFullYearView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 6,
      itemBuilder: (context, rowIndex) {
        return Row(
          children: List.generate(2, (colIndex) {
            int monthIndex = rowIndex * 2 + colIndex;
            final monthStartDate =
                DateTime(_focusedDay.year, monthIndex + 1, 1);
            final monthName =
                DateFormat.MMMM('ru').format(monthStartDate).toUpperCase();

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      monthName,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 42,
                      itemBuilder: (context, dayIndex) {
                        final daysInMonth = DateUtils.getDaysInMonth(
                            _focusedDay.year, monthIndex + 1);
                        final firstDayOfMonth =
                            DateTime(_focusedDay.year, monthIndex + 1, 1);
                        final firstDayOfWeek = firstDayOfMonth.weekday;
                        final day = dayIndex - (firstDayOfWeek - 1);

                        if (day <= 0 || day > daysInMonth) {
                          return const SizedBox.shrink();
                        }

                        final isToday = DateTime(_currentDate.year,
                                _currentDate.month, _currentDate.day)
                            .isAtSameMomentAs(DateTime(
                                _focusedDay.year, monthIndex + 1, day));

                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isToday
                                ? Colors.orange.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              '$day',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildMonthView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 12,
      itemBuilder: (context, index) {
        final monthStartDate = DateTime(_focusedDay.year, index + 1, 1);
        final monthName =
            DateFormat.MMMM('ru').format(monthStartDate).toUpperCase();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.y().format(monthStartDate),
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.375,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8),
              Text(
                monthName,
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.375,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0,
                ),
                itemCount: 42,
                itemBuilder: (context, dayIndex) {
                  final daysInMonth =
                      DateUtils.getDaysInMonth(_focusedDay.year, index + 1);
                  final firstDayOfMonth =
                      DateTime(_focusedDay.year, index + 1, 1);
                  final firstDayOfWeek = firstDayOfMonth.weekday;
                  final day = dayIndex - (firstDayOfWeek - 1);

                  if (day <= 0 || day > daysInMonth) {
                    return SizedBox.shrink();
                  }

                  final isToday = DateTime(_currentDate.year,
                          _currentDate.month, _currentDate.day)
                      .isAtSameMomentAs(
                          DateTime(_focusedDay.year, index + 1, day));

                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday
                          ? Colors.orange.withOpacity(0.5)
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.11,
                          color: Colors.black,
                          fontStyle:
                              isToday ? FontStyle.italic : FontStyle.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeekDays() {
    final List<String> daysOfWeek = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: daysOfWeek.map((day) {
          return Text(
            day,
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.grey,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Text('Сегодня'),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _currentDate = _focusedDay;
                _scrollToCurrentMonth();
              });
            },
          ),
          IconButton(
            icon: Text(_showFullYear ? 'Месяц' : 'Год'),
            onPressed: () {
              setState(() {
                _showFullYear = !_showFullYear;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32),
          child: _buildWeekDays(),
        ),
      ),
      body: _showFullYear ? _buildFullYearView() : _buildMonthView(),
    );
  }
}
