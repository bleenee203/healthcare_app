import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:healthcare_app/src/presentation/widgets/month_exercise_chart.dart';
import 'package:intl/intl.dart';

class MonthExerciseTab extends StatefulWidget {
  const MonthExerciseTab({super.key});

  @override
  State<MonthExerciseTab> createState() => _MonthExerciseTab();
}

class _MonthExerciseTab extends State<MonthExerciseTab> {
  late DateTime _datevalue;

  List<DateTime> initDayOfWeek(DateTime day) {
    List<DateTime> daysOfWeek = [];
    DateTime mondayOfThisWeek = day.subtract(
        Duration(days: day.weekday - 1)); // Lùi lại đến thứ Hai của tuần này

    // Generating days from today to Monday of this week
    if (day.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      for (DateTime i = day;
      i.isAfter(mondayOfThisWeek) || i.isAtSameMomentAs(mondayOfThisWeek);
      i = i.subtract(const Duration(days: 1))) {
        //String formattedDay = DateFormat('EEEE, d MMMM yyyy').format(day);
        daysOfWeek.add(i);
      }
      daysOfWeek.addAll(initDayOfWeek(
          daysOfWeek[daysOfWeek.length - 1].subtract(const Duration(days: 1))));
    } else {
      for (DateTime i = day;
      i.isAfter(mondayOfThisWeek) || i.isAtSameMomentAs(mondayOfThisWeek);
      i = i.subtract(const Duration(days: 1))) {
        //String formattedDay = DateFormat('EEEE, d MMMM yyyy').format(day);
        daysOfWeek.add(i);
      }
    }

    return daysOfWeek;
  }

  final _scrollController = ScrollController();
  var selectedButton = 0;

  // Dummy list of items
  List<DateTime> listDay = [];
  List<WaterPoint> points = [
    WaterPoint(0, 1600), // Điểm giá có x = 0 và y = 5
    WaterPoint(1, 1000), // Điểm giá có x = 1 và y = 8
    WaterPoint(2),
    WaterPoint(3),
    WaterPoint(4),
    WaterPoint(5),
    WaterPoint(6),
    // Thêm các điểm giá khác tại đây...
  ];

  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
    listDay = initDayOfWeek(DateTime.now().subtract(const Duration(days: 1)));
    _scrollController.addListener(_loadMoreItems);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // Function to simulate loading more items
  Future<void> _loadMoreItems() async {
    // Trigger loading more items when reaching the end of the list
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Simulating a delay of 1 second
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        listDay.addAll(initDayOfWeek(
            listDay[listDay.length - 1].subtract(const Duration(days: 1))));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          // const SizedBox(height: 24),
          if (selectedButton == 0)
            const MonthExerciseChartWidget()
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => _moveToPreviousMonth(context),
                        child: Image.asset("res/images/left.png")),
                    Text(
                      DateFormat('MMMM').format(_datevalue),
                      style: const TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: _datevalue.month == DateTime.now().month
                          ? null
                          : () => _moveToNextMonth(context),
                      child: Image.asset("res/images/right.png"),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
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
                BarChartWidget(points: points),
              ],
            ),
          const SizedBox(
            height: 23,
          ),
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
                  backgroundColor: selectedButton == 1
                      ? const Color(0xFFBBB7EA)
                      : const Color(0xFFFBEDEC),
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
            height: 22,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "This Month",
              style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 23,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("This week", style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: "SourceSans3",
                ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("3", style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: "SourceSans3"
                    ),),
                    Text("2 exercise types", style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listDay.length + 1, // Adding 1 for loading indicator
            itemBuilder: (context, index) {
              if (index == listDay.length) {
                // If reached the end of the list, show a loading indicator
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                // Displaying the actual item
                return Column(
                  children: [
                    if (listDay[index].weekday == DateTime.sunday)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  DateFormat('MMMM d').format(listDay[index]
                                      .subtract(const Duration(days: 6))),
                                  style: const TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  " - ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text(
                                  DateFormat('MMMM d').format(listDay[index]),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "SourceSans3",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("3", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: "SourceSans3"
                                ),),
                                Text("2 exercise types", style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 2,),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _moveToPreviousMonth(BuildContext context) {
    DateTime lastMonth =
    DateTime(_datevalue.year, _datevalue.month - 1, _datevalue.day);

// Xử lý trường hợp đặc biệt nếu tháng hiện tại là tháng 1
    if (_datevalue.month == 1) {
      int lastYear = _datevalue.year - 1;
      lastMonth = DateTime(lastYear, 12, _datevalue.day);
    }
    setState(() {
      _datevalue = lastMonth;
    });
  }

  void _moveToNextMonth(BuildContext context) {
    DateTime nextMonth =
    DateTime(_datevalue.year, _datevalue.month + 1, _datevalue.day);

// Xử lý trường hợp đặc biệt nếu tháng hiện tại là tháng 12
    if (_datevalue.month == 12) {
      int nextYear = _datevalue.year + 1;
      nextMonth = DateTime(nextYear, 1, _datevalue.day);
    }
    setState(() {
      _datevalue = nextMonth;
    });
  }
}
