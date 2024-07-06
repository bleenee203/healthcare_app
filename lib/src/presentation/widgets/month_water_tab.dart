import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/water_month_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:healthcare_app/src/services/drinkService.dart';

class MonthWaterTab extends StatefulWidget {
  final int water_target;
  const MonthWaterTab({super.key, required this.water_target});
  @override
  State<MonthWaterTab> createState() => _MonthWaterTab();
}

class _MonthWaterTab extends State<MonthWaterTab> {
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
        daysOfWeek.add(i);
      }
      daysOfWeek.addAll(initDayOfWeek(
          daysOfWeek[daysOfWeek.length - 1].subtract(const Duration(days: 1))));
    } else {
      for (DateTime i = day;
          i.isAfter(mondayOfThisWeek) || i.isAtSameMomentAs(mondayOfThisWeek);
          i = i.subtract(const Duration(days: 1))) {
        daysOfWeek.add(i);
      }
    }
    print(daysOfWeek);
    return daysOfWeek;
  }

  final _scrollController = ScrollController();
  // Dummy list of items
  // List<DateTime> listDay = [];
  DrinkService drinkService = DrinkService();
  Future<Map<String, dynamic>> _fetchDrink(String date) async {
    late double avg;
    final Map<String, dynamic> response =
        await drinkService.fetchDrinkByMonth(date);
    if (response.isEmpty) {
      return {};
    }
    final List<Map<String, dynamic>> drinks = response['drinks'] ?? [];
    avg = double.parse(response['avg']);
    List<WaterPoint> waterPoints = [];
    double count = 0;
    for (var drink in drinks) {
      int totalAmount = drink['totalAmount'];
      waterPoints.add(WaterPoint(count, totalAmount.toDouble()));
      count++;
    }

    return {'points': waterPoints, 'avg': avg, 'drinks': drinks};
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

  // void _loadMoreItems() {
  //   // Trigger loading more items when reaching the end of the list
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     setState(() {
  //       listDay.addAll(initDayOfWeek(
  //           listDay[listDay.length - 1].subtract(const Duration(days: 1))));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // controller: _scrollController,
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
              onTap: _datevalue.month == DateTime.now().month
                  ? null
                  : () => _moveToNextMonth(context),
              child: Image.asset("res/images/right.png"),
            )
          ],
        ),
        FutureBuilder<Map<String, dynamic>>(
            future: _fetchDrink(DateFormat('yyyy-MM-dd').format(_datevalue)),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final List<WaterPoint> points =
                    (snapshot.data!['points'] as List?)
                            ?.map((e) => e as WaterPoint)
                            .toList() ??
                        [];
                final double avg;
                if (isInSameMonth(_datevalue)) {
                  int count_day = DateTime.now().day - 1;
                  final List<WaterPoint> filteredPoints =
                      points.where((point) => point.x <= count_day).toList();
                  final double totalAmount =
                      filteredPoints.fold(0, (sum, point) => sum + point.y);
                  avg = double.parse(
                      (totalAmount / filteredPoints.length).toStringAsFixed(2));
                } else {
                  avg = (snapshot.data!['avg'] as double?) ?? 0.0;
                }
                return Column(
                  children: [
                    Text(
                      "${avg}ml (avg)",
                      style: TextStyle(
                        color: HexColor("474672").withOpacity(0.5),
                        fontFamily: "SourceSans3",
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    WaterMonthChart(points: points),
                  ],
                );
              }
            }),
        const SizedBox(
          height: 23,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Quick Add For Today",
            style: TextStyle(
                fontFamily: "SourceSans3",
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset("res/images/glass-of-water.png"),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  "1 glass",
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                  ),
                ),
                Text(
                  "(250 ml)",
                  style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.75)),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset("res/images/bottle.png"),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  "1 bottle",
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                  ),
                ),
                Text(
                  "(500 ml)",
                  style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.75)),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset("res/images/super_bottle.png"),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  "1 super bottle",
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                  ),
                ),
                Text(
                  "(750 ml)",
                  style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.75)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 28,
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
            future: _fetchDrink(DateFormat('yyyy-MM-dd').format(_datevalue)),
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
                    (snapshot.data!['drinks'] as List<Map<String, dynamic>>?) ??
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
                          Image.asset("res/images/glass-of-water.png"),
                          const SizedBox(
                            width: 10,
                          ),
                          Baseline(
                            baseline: 30.0,
                            baselineType: TextBaseline.alphabetic,
                            child: Text(
                              "${reversedPoints.first['totalAmount']}",
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
                            baseline:
                                30.0, // Adjust to a common baseline value for all text
                            baselineType: TextBaseline.alphabetic,
                            child: Text(
                              "${widget.water_target}",
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
                              "ml goal",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Spacer(),
                          (widget.water_target <=
                                  reversedPoints.first['totalAmount'])
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
                                    "${reversedPoints[index]['totalAmount']}ml",
                                    style: const TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                (widget.water_target <=
                                        reversedPoints[index]['totalAmount'])
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
    ));
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
