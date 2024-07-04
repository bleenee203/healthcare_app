import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class SleepGoalPage extends StatefulWidget {
  const SleepGoalPage({super.key});

  @override
  State<StatefulWidget> createState() => _SleepGoalPage();
}

class _SleepGoalPage extends State<SleepGoalPage> {
  var _reminderToggle = false;
  TimeOfDay selectedTime = TimeOfDay.now(); //Sau này sẽ lấy từ server để set thời gian ban đầu này
  TimeOfDay selectedTimeEnd = TimeOfDay.now(); //Khả năng cao sẽ lấy từ sharedpreferences

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
                  image: AssetImage("res/images/sleep-goal-background.png"),
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
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "SLEEP GOAL",
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
                    onTap: () =>
                        RouterCustom.router.pushNamed('set-sleep-goal'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Time Asleep Goal",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "SourceSans3"),
                        ),
                        Text(
                          "8 hr 5 min",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.75),
                              fontFamily: "SourceSans3"),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Text(
                    "TARGET SLEEP SCHEDULE",
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
                    onTap: () async {
                      // RouterCustom.router.pushNamed('set-sleep-start'),
                      final TimeOfDay? timeofDay = await showTimePicker(
                        context: context, initialTime: selectedTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeofDay != null ){
                        setState(() {
                          selectedTime = timeofDay;
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bedtime",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "SourceSans3"),
                        ),
                        Text(
                          "${selectedTime.hour}:${selectedTime.minute}",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.75),
                              fontFamily: "SourceSans3"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // RouterCustom.router.pushNamed('set-sleep-start'),
                      final TimeOfDay? timeofDay = await showTimePicker(
                        context: context, initialTime: selectedTimeEnd,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeofDay != null ){
                        setState(() {
                          selectedTimeEnd = timeofDay;
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Wake up Time",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "SourceSans3"),
                        ),
                        Text(
                          "${selectedTimeEnd.hour}:${selectedTimeEnd.minute}",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.75),
                              fontFamily: "SourceSans3"),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Text(
                    "BEDTIME REMINDER",
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
                    onTap: () {},
                    child: SizedBox(
                      width: 340,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Reminder",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "SourceSans3"),
                          ),
                          SizedBox(
                            height: 15,
                            width: 31,
                            child: Switch(
                              value: _reminderToggle,
                              onChanged: (value) {
                                setState(() {
                                  _reminderToggle = value;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ),
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
