import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MonthWaterTab extends StatefulWidget {
  const MonthWaterTab({super.key});
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
          Text(
            "2000ml (avg)",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset("res/images/glass-of-water.png"),
              const Text(
                "1000",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "ml of your ",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                ),
              ),
              const Text(
                "2000",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "ml goal",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                ),
              ),
              Image.asset("res/images/target.png")
            ],
          ),
          const Divider(
            thickness: 1,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: HexColor("BBB7EA")),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('MMMM d').format(listDay[index]
                                      .subtract(const Duration(days: 6))),
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
                                  DateFormat('MMMM d').format(listDay[index]),
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
                            DateFormat('EEEE').format(listDay[index]),
                            style: const TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "2000ml",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
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
