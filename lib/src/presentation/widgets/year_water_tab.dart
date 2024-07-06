import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:healthcare_app/src/presentation/widgets/water_year_chart.dart';
import 'package:healthcare_app/src/services/drinkService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YearWaterTab extends StatefulWidget {
  final int water_target;
  const YearWaterTab({super.key, required this.water_target});
  @override
  State<YearWaterTab> createState() => _YearWaterTab();
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

class _YearWaterTab extends State<YearWaterTab> {
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
      _startAlarmManager();
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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final _scrollController = ScrollController();

  // Dummy list of items
  // List<DateTime> listDay = [];
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
  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
    // listDay = initDayOfWeek(DateTime.now().subtract(const Duration(days: 1)));
    // _scrollController.addListener(_loadMoreItems);
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
    // _scrollController.dispose();
  }

  DrinkService drinkService = DrinkService();
  Future<Map<String, dynamic>> _fetchDrink(String date) async {
    try {
      late double avg;
      final Map<String, dynamic> response =
          await drinkService.fetchMonthDrinkByYear(date);
      if (response.isEmpty) {
        return {};
      }
      final List<Map<String, dynamic>> drinks = response['drinks'] ?? [];
      final List<Map<String, dynamic>> days = response['days'] ?? [];
      avg = double.parse(response['avg']);
      List<WaterPoint> waterPoints = [];
      double count = 0;
      for (var drink in drinks) {
        int totalAmount = drink['totalAmount'];
        waterPoints.add(WaterPoint(count, totalAmount.toDouble()));
        count++;
      }

      return {'points': waterPoints, 'avg': avg, 'days': days};
    } catch (error, stackTrace) {
      print('Error fetching drink data: $error');
      print('Stack trace: $stackTrace');
      return {};
    }
  }
  // Function to simulate loading more items
  // Future<void> _loadMoreItems() async {
  //   // Trigger loading more items when reaching the end of the list
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     // Simulating a delay of 1 second
  //     await Future.delayed(const Duration(seconds: 1));
  //     setState(() {
  //       listDay.addAll(initDayOfWeek(
  //           listDay[listDay.length - 1].subtract(const Duration(days: 1))));
  //     });
  //   }
  // }

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
              [];
              final List<Map<String, dynamic>> days =
                  (snapshot.data!['days'] as List<Map<String, dynamic>>?) ?? [];

              List<Map<String, dynamic>> reversedDays =
                  List.from(days.reversed);
              double avg = 0;
              if (isInSameYear(_datevalue)) {
                reversedDays = reversedDays
                    .where((day) => DateFormat('dd/MM/yyyy')
                        .parse(day['date'])
                        .isBefore(DateTime.now().subtract(Duration(days: 1))))
                    .toList();
                final double totalAmount = reversedDays.fold(
                    0, (sum, day) => sum + day['totalAmount']);
                avg = double.parse(
                    (totalAmount / reversedDays.length).toStringAsFixed(2));
              } else {
                avg = (snapshot.data!['avg'] as double?) ?? 0.0;
              }
              return Column(
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
                  WaterYearChart(points: points),
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
                  if (isInSameYear(_datevalue))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset("res/images/glass-of-water.png"),
                        Text(
                          "${reversedDays[0]['totalAmount']}",
                          style: const TextStyle(
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
                        Text(
                          "${widget.water_target}",
                          style: const TextStyle(
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
                    itemCount: reversedDays.length - 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if ((DateFormat('dd/MM/yyyy')
                                      .parse(reversedDays[index]['date']))
                                  .weekday ==
                              DateTime.sunday)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration:
                                    BoxDecoration(color: HexColor("BBB7EA")),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('MMMM d').format((DateFormat(
                                                    'dd/MM/yyyy')
                                                .parse(reversedDays[index]
                                                    ['date']))
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
                                        DateFormat('MMMM d').format(
                                            (DateFormat('dd/MM/yyyy').parse(
                                                reversedDays[index]['date']))),
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
                                      (DateFormat('dd/MM/yyyy')
                                          .parse(reversedDays[index]['date']))),
                                  style: const TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${reversedDays[index]['totalAmount']}ml",
                                  style: const TextStyle(
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
                    },
                  ),
                ],
              );
            }
          }),
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

  bool isInSameYear(DateTime dateToCompare) {
    DateTime now = DateTime.now();
    return dateToCompare.year == now.year;
  }
}
