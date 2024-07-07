import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../models/sleepModel.dart';
import '../../services/sleepServices.dart'; // Import thư viện để định dạng ngày tháng

class SleepLog extends StatefulWidget {
  const SleepLog({super.key});

  @override
  State<StatefulWidget> createState() => _SleepLog();
}

class _SleepLog extends State<SleepLog> {
  DateTime sleepStart = DateTime.now();
  DateTime sleepEnd = DateTime.now();

  final SleepService sleepService = SleepService();

  Future<Sleep?> _addSleepData(start_time, end_time, duration) async {
    final sleep = await sleepService.addSleepLog(start_time, end_time, duration);
    if (sleep != null) {
      Fluttertoast.showToast(
        msg: "Add new exercise log successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
    return null;
  }
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? sleepStart : sleepEnd,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          sleepStart = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, sleepStart.hour, sleepStart.minute);
        } else {
          sleepEnd = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
              sleepEnd.hour, sleepEnd.minute);
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStart ? sleepStart : sleepEnd),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          sleepStart = DateTime(sleepStart.year, sleepStart.month,
              sleepStart.day, pickedTime.hour, pickedTime.minute);
        } else {
          sleepEnd = DateTime(sleepEnd.year, sleepEnd.month, sleepEnd.day,
              pickedTime.hour, pickedTime.minute);
        }
      });
    }
  }

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
                      flex: 1,
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
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "LOG SLEEP",
                          style: TextStyle(
                            color: HexColor("474672"),
                            fontFamily: "SourceSans3",
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          int duration = (sleepEnd.hour*60+sleepEnd.minute) - (sleepStart.hour*60+sleepStart.minute);
                          _addSleepData(sleepStart, sleepEnd, duration);
                          if (RouterCustom.router.canPop()){
                            RouterCustom.router.pop();
                          }
                        },
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: "SourceSans3",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sleep Start",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF000000),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                await _selectDate(context, true);
                              },
                              child: Text(
                                DateFormat('EEE, MMM d, yyyy')
                                    .format(sleepStart),
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await _selectTime(context, true);
                          },
                          child: Center(
                            child: Text(
                              "${sleepStart.hour.toString().padLeft(2, '0')}:${sleepStart.minute.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sleep End",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF000000),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                await _selectDate(context, false);
                              },
                              child: Text(
                                DateFormat('EEE, MMM d, yyyy').format(sleepEnd),
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await _selectTime(context, false);
                          },
                          child: Center(
                            child: Text(
                              "${sleepEnd.hour.toString().padLeft(2, '0')}:${sleepEnd.minute.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
