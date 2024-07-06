import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:healthcare_app/src/services/drinkService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class WeekWaterTab extends StatefulWidget {
  final int water_target;
  const WeekWaterTab({super.key, required this.water_target});
  @override
  State<WeekWaterTab> createState() => _WeekWaterTab();
}

void showReminderNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'Notifications to remind you to drink water',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Đã đến giờ uống nước!',
    'Hãy uống nước để duy trì sức khoẻ!',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

class _WeekWaterTab extends State<WeekWaterTab> {
  DrinkService drinkService = DrinkService();
  Future<Map<String, dynamic>> _fetchDrink(String date) async {
    late double avg;
    final Map<String, dynamic> response = await drinkService.fetchDrink(date);
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
    return {'points': waterPoints, 'avg': avg};
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
      AndroidAlarmManager.cancel(0);

      // Bắt đầu lại alarm để nhắc nhở tiếp tục sau mỗi phút
      if (_isReminderOn) {
        _startAlarmManager();
      }
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
    // Khởi tạo plugin để hiển thị thông báo
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Bắt đầu alarm manager
    _loadReminderStatus();
  }

  bool _isReminderOn = false;
  Future<void> _loadReminderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isReminderOn = prefs.getBool('isReminderOn') ?? false;
      if (_isReminderOn) {
        _startAlarmManager();
      }
    });
  }

  void _startAlarmManager() {
    const oneMinute = Duration(hours: 1);
    AndroidAlarmManager.periodic(oneMinute, 0, showReminderNotification,
        exact: true, wakeup: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<Map<String, dynamic>>(
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
                    "$avg (avg)",
                    style: TextStyle(
                      color: HexColor("474672").withOpacity(0.5),
                      fontFamily: "SourceSans3",
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
                  ..._buildDayRows(points),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            }
          }),
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
          (widget.water_target <= filteredPoints.first.y.toInt())
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
            (widget.water_target <= point.y.toInt())
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
    DateTime lastweek = _datevalue.subtract(const Duration(days: 7));
    setState(() {
      _datevalue = lastweek;
    });
    _fetchDrink(DateFormat('yyyy-MM-dd').format(_datevalue));
  }

  void _moveToNextWeek(BuildContext context) {
    DateTime nextweek = _datevalue.add(const Duration(days: 7));
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
