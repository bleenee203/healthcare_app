import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthExerciseChartWidget extends StatefulWidget {
  const MonthExerciseChartWidget(
      {super.key,
        this.sunday = false,
        this.monday = false,
        this.tuesday = false,
        this.wednesday = false,
        this.thursday = false,
        this.friday = false,
        this.saturday = false});

  final bool sunday;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;

  @override
  State<MonthExerciseChartWidget> createState() =>
      _MonthExerciseChartWidgetState();
}

class _MonthExerciseChartWidgetState extends State<MonthExerciseChartWidget> {
  _MonthExerciseChartWidgetState();

  late final ValueNotifier<List<DateTime>> _selectedDays;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedDays = ValueNotifier([]);
  }

  @override
  void dispose() {
    _selectedDays.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ValueListenableBuilder<List<DateTime>>(
          valueListenable: _selectedDays,
          builder: (context, value, _) {
            return TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronVisible: true,
                rightChevronVisible: true,
                titleTextStyle: TextStyle(
                  fontFamily: "SourceSans3",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
              ),
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) {
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                todayBuilder: (context, date, events) {
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(
                text: "2 ",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              TextSpan(
                text: "exercise days",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
      ],
    );
  }
}
