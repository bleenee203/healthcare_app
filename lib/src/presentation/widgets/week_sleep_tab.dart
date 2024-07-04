import 'package:flutter/material.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../models/sleep_point.dart';

class WeekSleepTab extends StatefulWidget {
  const WeekSleepTab({super.key});

  @override
  State<WeekSleepTab> createState() => _WeekSleepTab();
}

class _WeekSleepTab extends State<WeekSleepTab> {
  int selectedButton = 0;
  late DateTime _datevalue;
  List<SleepPoint> points = [
    SleepPoint(0, 8), // Điểm giá có x = 0 và y = 5
    SleepPoint(1, 4), // Điểm giá có x = 1 và y = 8
    SleepPoint(2, 2),
    SleepPoint(3),
    SleepPoint(4),
    SleepPoint(5),
    SleepPoint(6),
    // Thêm các điểm giá khác tại đây...
  ];

  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => _moveToPreviousWeek(context),
                  child: Image.asset("res/images/left.png")),
              Text(
                getWeekRangeString(_datevalue),
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: _datevalue.day == DateTime.now().day
                    ? null
                    : () => _moveToNextWeek(context),
                child: Image.asset("res/images/right.png"),
              )
            ],
          ),
          Text(
            "8h (avg)",
            style: TextStyle(
              color: HexColor("474672").withOpacity(0.5),
              fontFamily: "SourceSans3",
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 78,
          ),
          BarChartWidget(points: points),
          const SizedBox(
            height: 23,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() => selectedButton = 0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedButton == 0 ? const Color(0xFFBBB7EA) : const Color(0xFFFBEDEC),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFFBBB7EA),
                      width: 1,
                    ),
                  ),
                ),
                child: const Text('Hours Slept'),
              ),
              const SizedBox(
                width: 22,
              ),
              ElevatedButton(
                onPressed: () => setState(() => selectedButton = 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedButton == 1 ? const Color(0xFFBBB7EA) : const Color(0xFFFBEDEC),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFFBBB7EA),
                      width: 1,
                    ),
                  ),
                ),
                child: const Text('Sleep schedule'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _moveToPreviousWeek(BuildContext context) {
    DateTime lastweek = _datevalue.subtract(const Duration(days: 7));
    setState(() {
      _datevalue = lastweek;
    });
  }

  void _moveToNextWeek(BuildContext context) {
    DateTime nextweek = _datevalue.add(const Duration(days: 7));
    setState(() {
      _datevalue = nextweek;
    });
  }

  String getWeekRangeString(DateTime date) {
    // Lấy ngày đầu tiên của tuần (Chủ nhật)
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Lấy ngày cuối cùng của tuần (Thứ bảy)
    DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    // Biến đổi ngày thành chuỗi
    String firstDayString = DateFormat('MMMM d').format(firstDayOfWeek);
    String lastDayString = DateFormat('MMMM d').format(lastDayOfWeek);

    return '$firstDayString - $lastDayString';
  }
}
