import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TreeMonthWaterTab extends StatefulWidget {
  const TreeMonthWaterTab({super.key});
  @override
  State<TreeMonthWaterTab> createState() => _TreeMonthWaterTab();
}

class _TreeMonthWaterTab extends State<TreeMonthWaterTab> {
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
    print(_datevalue);

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => _moveToPreviousQuarter(context),
                  child: Image.asset("res/images/left.png")),
              Text(
                getCurrentQuarterString(_datevalue),
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: isInCurrentQuarter(_datevalue)
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
              )
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

  void _moveToPreviousQuarter(BuildContext context) {
    int currentMonth = _datevalue.month;
    int currentYear = _datevalue.year;

    int startMonth;
    if (currentMonth <= 3) {
      startMonth = 10; // Tháng 10 năm trước
      currentYear--; // Giảm năm đi một đơn vị
    } else if (currentMonth <= 6) {
      startMonth = 1; // Tháng 1
    } else if (currentMonth <= 9) {
      startMonth = 4; // Tháng 4
    } else {
      startMonth = 7; // Tháng 7
    }

    // Tạo một đối tượng DateTime mới với tháng đầu tiên của quý trước đó
    DateTime previousQuarterStart = DateTime(currentYear, startMonth, 1);

    setState(() {
      _datevalue = previousQuarterStart;
    });
  }

  void _moveToNextMonth(BuildContext context) {
    int currentMonth = _datevalue.month;
    int currentYear = _datevalue.year;
    int systemMonth = DateTime.now().month;
    int systemQuarter = ((systemMonth - 1) / 3).floor() + 1;
    int appQuarter = ((currentMonth - 1) / 3).floor() + 1;

    // Kiểm tra nếu tháng hiện tại của ứng dụng thuộc quý hiện tại của hệ thống
    if (appQuarter == systemQuarter) {
      return; // Không làm gì nếu tháng hiện tại thuộc quý hiện tại
    }
    int startMonth;
    if (currentMonth >= 10) {
      startMonth = 1; // Tháng 10 năm trước
      currentYear++; // Giảm năm đi một đơn vị
    } else if (currentMonth >= 7) {
      startMonth = 10; // Tháng 1
    } else if (currentMonth >= 4) {
      startMonth = 7; // Tháng 4
    } else {
      startMonth = 4; // Tháng 7
    }

    // Tạo một đối tượng DateTime mới với tháng đầu tiên của quý trước đó
    DateTime previousQuarterStart = DateTime(currentYear, startMonth, 1);

    setState(() {
      _datevalue = previousQuarterStart;
    });
  }

  List<DateTime> getCurrentQuarterMonths(DateTime date) {
    int currentMonth = date.month;
    int currentYear = date.year;

    int startMonth;
    if (currentMonth % 3 == 0) {
      startMonth = currentMonth - 2;
    } else {
      startMonth = currentMonth - (currentMonth % 3) + 1;
    }

    List<DateTime> quarterMonths = [];
    for (int i = 0; i < 3; i++) {
      int month = startMonth + i;
      int year = currentYear;

      if (month > 12) {
        month -= 12;
        year++;
      }
      quarterMonths
          .add(DateTime(year, month, 1)); // Lấy ngày đầu tiên của mỗi tháng
    }

    return quarterMonths;
  }

  String getCurrentQuarterString(DateTime date) {
    List<DateTime> quarterMonths = getCurrentQuarterMonths(date);

    String startMonth = DateFormat('MMMM').format(quarterMonths[0]);
    String endMonth = DateFormat('MMMM').format(quarterMonths[2]);

    return '$startMonth - $endMonth';
  }

  bool isInCurrentQuarter(DateTime date) {
    List<DateTime> quarterMonths = getCurrentQuarterMonths(DateTime.now());

    DateTime startQuarter = quarterMonths[0];
    DateTime endQuarter = quarterMonths[2];
    print(startQuarter);
    print(endQuarter);
    return date.isAfter(startQuarter) && date.isBefore(endQuarter) ||
        date.isAtSameMomentAs(startQuarter) ||
        date.isAtSameMomentAs(endQuarter);
  }
}
