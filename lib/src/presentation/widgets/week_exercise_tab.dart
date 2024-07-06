import 'package:flutter/material.dart';
import 'package:healthcare_app/src/presentation/widgets/week_exercise_chart.dart';
import 'package:intl/intl.dart';

import '../../models/exercise_point.dart';
import '../../services/exercise_services.dart';
import 'bar_chart.dart';

class WeekExerciseTab extends StatefulWidget {
  const WeekExerciseTab({super.key});

  @override
  State<WeekExerciseTab> createState() => _WeekExerciseTab();
}

class _WeekExerciseTab extends State<WeekExerciseTab> {
  int selectedButton = 0;
  final _scrollController = ScrollController();
  late DateTime _datevalue;
  //
  // List<ExercisePoint> points = [
  //   ExercisePoint(0, 60), // Điểm giá có x = 0 và y = 5
  //   ExercisePoint(1, 30), // Điểm giá có x = 1 và y = 8
  //   ExercisePoint(2),
  //   ExercisePoint(3),
  //   ExercisePoint(4),
  //   ExercisePoint(5),
  //   ExercisePoint(6),
  // ];

  ExerciseService exerciseService = ExerciseService();
  List<ExercisePoint> points = [];

  Future<List<ExercisePoint>> _fetchExercise(String date) async {
    final List<Map<String, dynamic>> exercises =
    await exerciseService.fetchExercise(date);
    List<ExercisePoint> exercisePoints = [];
    double count = 0;
    for (var exercise in exercises) {
      int totalCaloBurn = exercise['totalCaloBurn'];
      exercisePoints.add(ExercisePoint(count, totalCaloBurn.toDouble()));
      count++;
    }
    return exercisePoints;
  }

  List<DateTime> initDayOfWeek(DateTime day) {
    List<DateTime> daysOfWeek = [];
    DateTime mondayOfThisWeek = day.subtract(
        Duration(days: day.weekday - 1)); // Lùi lại đến thứ Hai của tuần này

    for (DateTime i = day;
        i.isAfter(mondayOfThisWeek) || i.isAtSameMomentAs(mondayOfThisWeek);
        i = i.subtract(const Duration(days: 1))) {
      daysOfWeek.add(i);
    }

    return daysOfWeek;
  }

  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
    _fetchExercise(DateFormat('yyyy-MM-dd').format(_datevalue));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
          const SizedBox(height: 30),
          if (selectedButton == 0)
            const WeekExerciseChartWidget(
                monday: true,
                wednesday: true,
                thursday: true,
                friday: false,
                saturday: true,
                sunday: false)
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                        text: "45",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w600,
                          fontSize: 36,
                        ),
                      ),
                      TextSpan(
                        text: "min ",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                      ),
                      TextSpan(
                        text: " per exercise",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "You exercise for a total of 1 hours 30 minutes so far this week",
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder<List<ExercisePoint>>(
                  future: _fetchExercise(DateFormat('yyyy-MM-dd').format(_datevalue)),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ExercisePoint>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No data available');
                    } else {
                      return BarChartWidget(points: snapshot.data!);
                    }
                  },
                ),
              ],
            ),
          const SizedBox(height: 30),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() => selectedButton = 0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedButton == 0
                      ? const Color(0xFFBBB7EA)
                      : const Color(0xFFFBEDEC),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFFBBB7EA), width: 1),
                  ),
                ),
                child: const Text('Exercise Days'),
              ),
              const SizedBox(width: 22),
              ElevatedButton(
                onPressed: () => setState(() => selectedButton = 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedButton == 1
                      ? const Color(0xFFBBB7EA)
                      : const Color(0xFFFBEDEC),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFFBBB7EA), width: 1),
                  ),
                ),
                child: const Text('Duration'),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Today",
              style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "8:01 PM",
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Swim",
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "1m - 30 min",
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            // width: 360,
            // height: 70,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "8:01 PM",
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Run",
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "1m - 30 min",
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 23),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // itemCount: listDay.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // DateFormat('EEEE').format(listDay[index]),
                    "hehe",
                    style: const TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // width: 360,
                    // height: 70,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "8:01 PM",
                          style: TextStyle(
                            fontFamily: "SourceSans3",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Run",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "1m - 30 min",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
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
    _fetchExercise(DateFormat('yyyy-MM-dd').format(_datevalue));
  }

  void _moveToNextWeek(BuildContext context) {
    DateTime nextweek = _datevalue.add(const Duration(days: 7));
    setState(() {
      _datevalue = nextweek;
    });
    // _fetchExercise(DateFormat('yyyy-MM-dd').format(_datevalue));
  }

  String getWeekRangeString(DateTime date) {
    // Lấy ngày đầu tiên của tuần (Thứ Hai)
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Lấy ngày cuối cùng của tuần (Chủ nhật)
    DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    // Biến đổi ngày thành chuỗi
    String firstDayString = DateFormat('MMMM d').format(firstDayOfWeek);
    String lastDayString = DateFormat('MMMM d').format(lastDayOfWeek);

    return '$firstDayString - $lastDayString';
  }
}
