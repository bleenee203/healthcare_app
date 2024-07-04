import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:healthcare_app/src/services/drinkService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class WeekWaterTab extends StatefulWidget {
  const WeekWaterTab({super.key});
  @override
  State<WeekWaterTab> createState() => _WeekWaterTab();
}

class _WeekWaterTab extends State<WeekWaterTab> {
  DrinkService drinkService = DrinkService();
  List<WaterPoint> points = [];

  Future<List<WaterPoint>> _fetchDrink(String date) async {
    final List<Map<String, dynamic>> drinks =
        await drinkService.fetchDrink(date);
    List<WaterPoint> waterPoints = [];
    double count = 0;
    for (var drink in drinks) {
      int totalAmount = drink['totalAmount'];
      waterPoints.add(WaterPoint(count, totalAmount.toDouble()));
      count++;
    }
    return waterPoints;
  }

  Future<void> _addWaterLog(int amount) async {
    if (await drinkService.addWaterLog(amount)) {
      Fluttertoast.showToast(
        msg: "Add water log successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      setState(() {});
    } else {
      Fluttertoast.showToast(
        msg: "An error occurred while adding the water intake log",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  late DateTime _datevalue;

  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
    _fetchDrink(DateFormat('yyyy-MM-dd').format(_datevalue));
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
          FutureBuilder<List<WaterPoint>>(
            future: _fetchDrink(DateFormat('yyyy-MM-dd').format(_datevalue)),
            builder: (BuildContext context,
                AsyncSnapshot<List<WaterPoint>> snapshot) {
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
          const SizedBox(
            height: 23,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Quick Add For Today",
              style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _addWaterLog(250);
                },
                child: Column(
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
              ),
              GestureDetector(
                onTap: () {
                  _addWaterLog(500);
                },
                child: Column(
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
              ),
              GestureDetector(
                onTap: () {
                  _addWaterLog(750);
                },
                child: Column(
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
              )
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          FutureBuilder<List<WaterPoint>>(
            future: _fetchDrink(DateFormat('yyyy-MM-dd').format(_datevalue)),
            builder: (BuildContext context,
                AsyncSnapshot<List<WaterPoint>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No data available');
              } else {
                return Column(
                  children: [..._buildDayRows(snapshot.data!)],
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
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

  List<Widget> _buildDayRows(List<WaterPoint> points) {
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
            child: const Text(
              "2000",
              style: TextStyle(
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
                "${point.y.toInt()} ml",
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
    DateTime lastweek = _datevalue.subtract(Duration(days: 7));
    setState(() {
      _datevalue = lastweek;
    });
    _fetchDrink(DateFormat('yyyy-MM-dd').format(_datevalue));
  }

  void _moveToNextWeek(BuildContext context) {
    DateTime nextweek = _datevalue.add(Duration(days: 7));
    setState(() {
      _datevalue = nextweek;
    });
  }

  String getWeekRangeString(DateTime date) {
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
    String firstDayString = DateFormat('MMMM d').format(firstDayOfWeek);
    String lastDayString = DateFormat('MMMM d').format(lastDayOfWeek);
    return '$firstDayString - $lastDayString';
  }
}
