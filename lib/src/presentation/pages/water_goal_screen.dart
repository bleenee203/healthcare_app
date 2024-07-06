import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare_app/src/models/userModel.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/userService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterGoalPage extends StatefulWidget {
  const WaterGoalPage({super.key});

  @override
  State<StatefulWidget> createState() => _WaterGoalPage();
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

class _WaterGoalPage extends State<WaterGoalPage> {
  final UserService userService = UserService();
  int? water_target;
  Future<User?> _fetchUserData() async {
    final user = await userService.fetchUserData();
    return user;
  }

  bool _isReminderOn = false;

  Future<void> _loadReminderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Kiểm tra nếu `isReminderOn` chưa được khởi tạo
    if (!prefs.containsKey('isReminderOn')) {
      prefs.setBool('isReminderOn', false); // Đặt giá trị mặc định là false
    }
    setState(() {
      _isReminderOn = prefs.getBool('isReminderOn') ?? false;
      if (_isReminderOn) {
        _startAlarmManager();
      }
    });
  }

  void _startAlarmManager() {
    const oneMinute = Duration(minutes: 2);
    AndroidAlarmManager.periodic(oneMinute, 0, showReminderNotification,
        exact: true, wakeup: true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadReminderStatus();
  }

  void _toggleReminder(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isReminderOn = value;
      prefs.setBool('isReminderOn', _isReminderOn);
      if (_isReminderOn) {
        // Start the alarm manager if the reminder is turned on
        _startAlarmManager();
      } else {
        // Cancel the alarm manager if the reminder is turned off
        AndroidAlarmManager.cancel(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: HexColor("FBEDEC"),
          height: double.infinity,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("res/images/image-removebg-preview.png"),
            )),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              if (RouterCustom.router.canPop()) {
                                RouterCustom.router.pop();
                              }
                            },
                            child: Image.asset('res/images/go-back.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "WATER",
                            style: TextStyle(
                              color: HexColor("474672"),
                              fontFamily: "SourceSans3",
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "WATER GOAL",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: HexColor("474672"),
                        fontFamily: "SourceSans3"),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () => RouterCustom.router
                        .pushNamed('set-water-goal', extra: water_target)
                        .then((_) => setState(() {})),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Daily Water Goal",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "SourceSans3"),
                        ),
                        FutureBuilder<User?>(
                            future: _fetchUserData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<User?> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    'Error: ${snapshot.error}',
                                    style: const TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 24),
                                  ),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data?.water_target == null) {
                                return Text(
                                  "No data",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.75),
                                      fontFamily: "SourceSans3"),
                                );
                              } else {
                                User? user = snapshot.data;
                                water_target = user?.water_target;
                                return Text(
                                  "${user?.water_target}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.75),
                                      fontFamily: "SourceSans3"),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  SwitchListTile(
                    title: Text('Turn on/off reminder'),
                    value: _isReminderOn,
                    onChanged: _toggleReminder,
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    "Water is essential to good health and helps prevent  dehydration. While water needs vary from person to person, we often need at least 2000ml of water a day.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.75),
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
