import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class YearSleepTab extends StatefulWidget {
  const YearSleepTab({super.key});
  @override
  State<YearSleepTab> createState() => _YearSleepTab();
}

class _YearSleepTab extends State<YearSleepTab> {
  late DateTime _datevalue;
  var selectedButton = 0;
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
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => _moveToPreviousYear(context),
                  child: Image.asset("res/images/left.png")),
              Text(
                DateFormat('yyyy').format(_datevalue),
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: _datevalue.year == DateTime.now().year
                    ? null
                    : () => _moveToNextYear(context),
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

  void _moveToPreviousYear(BuildContext context) {
    DateTime lastYear =
    DateTime(_datevalue.year - 1, _datevalue.month, _datevalue.day);

    setState(() {
      _datevalue = lastYear;
    });
  }

  void _moveToNextYear(BuildContext context) {
    DateTime lastYear =
    DateTime(_datevalue.year + 1, _datevalue.month, _datevalue.day);

    setState(() {
      _datevalue = lastYear;
    });
  }
}
