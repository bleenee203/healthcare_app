import 'package:flutter/material.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../models/sleep_point.dart';
import '../../services/sleepServices.dart';

class WeekSleepTab extends StatefulWidget {
  final int sleep_target;
  const WeekSleepTab({super.key, required this.sleep_target});

  @override
  State<WeekSleepTab> createState() => _WeekSleepTab();
}

class _WeekSleepTab extends State<WeekSleepTab> {
  int selectedButton = 0;
  late DateTime _datevalue;
  SleepService sleepService = SleepService();
  Future<Map<String, dynamic>> _fetchSleep(String date) async {
    late double avg;
    final Map<String, dynamic> response = await sleepService.fetchSleep(date);
    if (response.isEmpty) {
      return {};
    }
    final List<Map<String, dynamic>> sleeps = response['sleeps'] ?? [];
    avg = double.parse(response['avg']);
    List<SleepPoint> sleepPoints = [];
    double count = 0;
    for (var sleep in sleeps) {
      int totalDuration = sleep['totalDuration'];
      sleepPoints.add(SleepPoint(count, totalDuration.toDouble()));
      count++;
    }
    return {'points': sleepPoints, 'avg': avg};
  }

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
      child: FutureBuilder<Map<String, dynamic>>(
        future: _fetchSleep(DateFormat('yyyy-MM-dd').format(_datevalue)),
        builder: (BuildContext context,
        AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Center(child: Text('No data available'));
            } else {
                final List<SleepPoint> points =
                (snapshot.data!['points'] as List?)
                    ?.map((e) => e as SleepPoint)
                    .toList() ?? [];
                final double avg = (snapshot.data!['avg'] as double?) ?? 0.0;
                return Column(
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
                    const SizedBox(
                      height: 28,
                    ),
                    ..._buildDayRows(points),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
            }
        }
        )
    );
  }

  String _getDayOfWeek(int index) {
    switch (index) {
      case 0:
        return "Monday";
      case 1:
        return "Tuesday";
      case 2:
        return "Wednesday";
      case 3:
        return "Thursday";
      case 4:
        return "Friday";
      case 5:
        return "Saturday";
      case 6:
        return "Sunday";
      default:
        return "";
    }
  }
  bool isInSameWeek(DateTime dateToCompare) {
    int currentWeekNumber =
        DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays ~/
            7;
    int compareWeekNumber =
        dateToCompare.difference(DateTime(dateToCompare.year, 1, 1)).inDays ~/
            7;
    return currentWeekNumber == compareWeekNumber &&
        DateTime.now().weekday != 7;
  }

  List<Widget> _buildDayRows(List<SleepPoint> points) {
    List<Widget> rows = [];

    if (isInSameWeek(_datevalue)) {
      rows.add(
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Today",
            style: TextStyle(
                fontFamily: "SourceSans3",
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
      rows.add(
        const SizedBox(
          height: 15,
        ),
      );
      var filteredPoints = points.reversed
          .where((point) => point.x <= DateTime.now().weekday - 1)
          .toList();
      rows.add(Row(
        children: [
          Image.asset("res/images/glass-of-water.png"),
          const SizedBox(
            width: 10,
          ),
          Baseline(
            baseline: 30.0,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "${filteredPoints.first.y.toInt()}",
              style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          const Baseline(
            baseline: 30.0, // Adjust to a common baseline value for all text
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "ml of your ",
              style: TextStyle(
                fontFamily: "SourceSans3",
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Baseline(
            baseline: 30.0, // Adjust to a common baseline value for all text
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "${widget.sleep_target}",
              style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          const Baseline(
            baseline: 30.0, // Adjust to a common baseline value for all text
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "ml goal",
              style: TextStyle(
                fontFamily: "SourceSans3",
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),
          (widget.sleep_target <= filteredPoints.first.y.toInt())
              ? Image.asset("res/images/target.png")
              : const SizedBox()
        ],
      ));
      rows.add(const Divider(
        thickness: 1,
      ));
      for (int i = 1; i < filteredPoints.length; i++) {
        var point = filteredPoints[i];
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _getDayOfWeek(point.x.toInt()),
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              width: 60,
            ),
            Expanded(
              child: Text(
                "${point.y.toInt()}ml",
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                ),
              ),
            ),
            // const Spacer(),
            const Spacer(),
            (widget.sleep_target <= point.y.toInt())
                ? Image.asset("res/images/target.png")
                : const SizedBox(
              width: 20,
            )
          ],
        ));
        if (i < filteredPoints.length - 1) {
          rows.add(const Divider(thickness: 1));
        }
      }
    } else {
      for (int i = points.length - 1; i >= 0; i--) {
        var point = points[i];
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _getDayOfWeek(point.x.toInt()),
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              width: 60,
            ),
            Expanded(
              child: Text(
                "${point.y.toInt()} minutes",
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ));
        if (i > 0) {
          rows.add(const Divider(thickness: 1));
        }
      }
    }

    return rows;
  }

  void _moveToPreviousWeek(BuildContext context) {
    DateTime lastweek = _datevalue.subtract(const Duration(days: 7));
    setState(() {
      _datevalue = lastweek;
    });
    _fetchSleep(DateFormat('yyyy-MM-dd').format(_datevalue));
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
