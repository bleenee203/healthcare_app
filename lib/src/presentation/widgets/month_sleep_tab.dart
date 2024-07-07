import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:healthcare_app/src/presentation/widgets/water_month_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../models/sleep_point.dart';
import '../../services/sleepServices.dart';

class MonthSleepTab extends StatefulWidget {
  final int sleep_target;

  const MonthSleepTab({super.key, required this.sleep_target});

  @override
  State<MonthSleepTab> createState() => _MonthSleepTab();
}

class _MonthSleepTab extends State<MonthSleepTab> {
  late DateTime _datevalue;

  List<DateTime> initDayOfWeek(DateTime day) {
    List<DateTime> daysOfWeek = [];
    DateTime mondayOfThisWeek = day.subtract(
        Duration(days: day.weekday - 1)); // Lùi lại đến thứ Hai của tuần này

    // Generating days from today to Monday of this week
    if (day.day == DateTime
        .now()
        .subtract(const Duration(days: 1))
        .day) {
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

  // List<WaterPoint> points = [
  //   WaterPoint(0, 1600), // Điểm giá có x = 0 và y = 5
  //   WaterPoint(1, 1000), // Điểm giá có x = 1 và y = 8
  //   WaterPoint(2),
  //   WaterPoint(3),
  //   WaterPoint(4),
  //   WaterPoint(5),
  //   WaterPoint(6),
  //   // Thêm các điểm giá khác tại đây...
  // ];
  SleepService sleepService = SleepService();

  Future<Map<String, dynamic>> _fetchSleep(String date) async {
    late double avg;
    final Map<String, dynamic> response =
    await sleepService.fetchSleepByMonth(date);
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
    return {'points': sleepPoints, 'avg': avg, 'sleeps': sleeps};
  }

    @override
    void initState() {
      super.initState();
      _datevalue = DateTime.now();
      // listDay = initDayOfWeek(DateTime.now().subtract(const Duration(days: 1)));
      // _scrollController.addListener(_loadMoreItems);
    }

    @override
    void dispose() {
      super.dispose();
      // _scrollController.dispose();
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
                  onTap: _datevalue.month == DateTime
                      .now()
                      .month
                      ? null
                      : () => _moveToNextMonth(context),
                  child: Image.asset("res/images/right.png"),
                )
              ],
            ),
            FutureBuilder<Map<String, dynamic>>(
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
                            .toList() ??
                            [];
                    final double avg;
                    if (isInSameMonth(_datevalue)) {
                      int count_day = DateTime.now().day - 1;
                      final List<SleepPoint> filteredPoints =
                      points.where((point) => point.x <= count_day).toList();
                      final double totalDuration =
                      filteredPoints.fold(0, (sum, point) => sum + point.y);
                      avg = double.parse(
                          (totalDuration / filteredPoints.length).toStringAsFixed(2));
                    } else {
                      avg = (snapshot.data!['avg'] as double?) ?? 0.0;
                    }
                    return Column(
                      children: [
                        Text(
                          "${avg}min (avg)",
                          style: TextStyle(
                            color: HexColor("474672").withOpacity(0.5),
                            fontFamily: "SourceSans3",
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 78,
                        ),
                        WaterMonthChart(points: points),
                        const SizedBox(
                          height: 23,
                        ),
                      ],
                    );
                  }
                }),
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
                "Today",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            FutureBuilder<Map<String, dynamic>>(
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
                    final List<Map<String, dynamic>> points =
                        (snapshot.data!['sleeps'] as List<Map<String, dynamic>>?) ??
                            [];
                    List<Map<String, dynamic>> reversedPoints =
                    List.from(points.reversed);
                    if (isInSameMonth(_datevalue)) {
                      reversedPoints = reversedPoints
                          .where((point) =>
                      DateFormat('dd/MM/yyyy').parse(point['date']).day <=
                          DateTime.now().day)
                          .toList();
                    }
                    return Column(
                      children: [
                        if (isInSameMonth(_datevalue))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Image.asset("res/images/glass-of-water.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Baseline(
                                baseline: 30.0,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  "${reversedPoints.first['totalDuration']}",
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
                                baseline: 30.0,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  "min of your ",
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
                                baseline:
                                30.0, // Adjust to a common baseline value for all text
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
                                baseline:
                                30.0, // Adjust to a common baseline value for all text
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  "min goal",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              (widget.sleep_target <=
                                  reversedPoints.first['totalDuration'])
                                  ? Image.asset("res/images/target.png")
                                  : const SizedBox()
                            ],
                          ),
                        const Divider(
                          thickness: 1,
                        ),
                        ListView.builder(
                          // controller: _scrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: reversedPoints.length - 1,
                          itemBuilder: (context, index) {
                            index = index + 1;
                            print(index);
                            return Column(
                              children: [
                                if ((DateFormat('dd/MM/yyyy')
                                    .parse(reversedPoints[index]['date']))
                                    .weekday ==
                                    DateTime.sunday)
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration:
                                      BoxDecoration(color: HexColor("BBB7EA")),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              DateFormat('MMMM d').format(
                                                  (DateFormat('dd/MM/yyyy').parse(
                                                      reversedPoints[index]
                                                      ['date']))
                                                      .subtract(
                                                      const Duration(days: 6))),
                                              style: const TextStyle(
                                                fontFamily: "SourceSans3",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              " - ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "SourceSans3",
                                              ),
                                            ),
                                            Text(
                                              DateFormat('MMMM d').format(
                                                  (DateFormat('dd/MM/yyyy').parse(
                                                      reversedPoints[index]
                                                      ['date']))),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: "SourceSans3",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        DateFormat('EEEE').format(
                                            (DateFormat('dd/MM/yyyy').parse(
                                                reversedPoints[index]['date']))),
                                        style: const TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${reversedPoints[index]['totalDuration']}min",
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    (widget.sleep_target <=
                                        reversedPoints[index]['totalDuration'])
                                        ? Image.asset("res/images/target.png")
                                        : const SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }
                }),
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

bool isInSameMonth(DateTime dateToCompare) {
  DateTime now = DateTime.now();
  return dateToCompare.year == now.year && dateToCompare.month == now.month;
}
