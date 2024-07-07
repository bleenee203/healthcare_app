import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/userModel.dart';
import '../../services/userService.dart';

class SleepSetGoalPage extends StatefulWidget {
  const SleepSetGoalPage({super.key});

  @override
  State<StatefulWidget> createState() => _SleepSetGoalPage();
}

class _SleepSetGoalPage extends State<SleepSetGoalPage> {
  int _sleepHours = 0;
  int _sleepMin = 0;

  final UserService userService = UserService();

  Future<User?> _updateUserData(newData) async {
    final user = await userService.updateUserData(newData);
    if (user != null) {
      Fluttertoast.showToast(
        msg: "Set goal successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
    return null;
  }

  final FixedExtentScrollController _hoursController =
      FixedExtentScrollController(initialItem: 0);
  final FixedExtentScrollController _minutesController =
      FixedExtentScrollController(initialItem: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: HexColor("FBEDEC"),
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          "SLEEP",
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0)
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: NotificationListener<ScrollEndNotification>(
                              onNotification: (notification) {
                                // if (notification is ScrollEndNotification) {
                                //   _centerItem(_hoursController, 24);
                                // }
                                return true;
                              },
                              child: ListWheelScrollView.useDelegate(
                                physics: const FixedExtentScrollPhysics(),
                                controller: _hoursController,
                                itemExtent: 120,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _sleepHours = index % 24;
                                  });
                                },
                                childDelegate:
                                    ListWheelChildLoopingListDelegate(
                                  children:
                                      List<Widget>.generate(24, (int index) {
                                    return Center(
                                      child: Text(
                                        (index % 24).toString().length == 1
                                            ? "0${index % 24}"
                                            : (index % 24).toString(),
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontWeight: FontWeight.w900,
                                          fontSize: 60,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Hours",
                            style: TextStyle(
                                fontFamily: "SourceSans3", fontSize: 20),
                          ),
                        ],
                      ),
                      const Text(
                        "-",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 90,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: NotificationListener<ScrollEndNotification>(
                              onNotification: (notification) {
                                // if (notification is ScrollEndNotification) {
                                //   _centerItem(_minutesController, 60);
                                // }
                                return true;
                              },
                              child: ListWheelScrollView.useDelegate(
                                physics: const FixedExtentScrollPhysics(),
                                controller: _minutesController,
                                itemExtent: 120,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _sleepMin = index % 60;
                                  });
                                },
                                childDelegate:
                                    ListWheelChildLoopingListDelegate(
                                  children:
                                      List<Widget>.generate(60, (int index) {
                                    return Center(
                                      child: Text(
                                        (index % 60).toString().length == 1
                                            ? "0${index % 60}"
                                            : (index % 60).toString(),
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontWeight: FontWeight.w900,
                                          fontSize: 60,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Minutes",
                            style: TextStyle(
                                fontFamily: "SourceSans3", fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(344, 60),
                        padding: const EdgeInsets.fromLTRB(68, 16, 68, 16),
                        backgroundColor: const Color(0xFF474672),
                      ),
                      onPressed: () {
                        User data = User(
                            sleep_target:
                                ((_hoursController.selectedItem % 24) * 60 +
                                    (_minutesController.selectedItem % 60)));
                        _updateUserData(data);
                        if (RouterCustom.router.canPop()) {
                          RouterCustom.router.pop();
                        }
                      },
                      child: const Text(
                        'SET GOAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SourceSans3",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
