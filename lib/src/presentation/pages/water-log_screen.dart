import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/drinkService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class WaterLogPage extends StatefulWidget {
  const WaterLogPage({super.key});

  @override
  State<StatefulWidget> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterLogPage> {
  DrinkService drinkService = DrinkService();
  Future<void> _addWaterLog(String date, int amount) async {
    if (await drinkService.addWaterLogByDate(date,amount)) {
      Fluttertoast.showToast(
        msg: "Add water log successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pop(context);
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

  @override
  void initState() {
    super.initState();
  }

  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: HexColor("fbedec"),
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (RouterCustom.router.canPop()) {
                            RouterCustom.router.pop();
                          }
                        },
                        child: Image.asset('res/images/go-back.png'),
                      ),
                      Text(
                        "WATER",
                        style: TextStyle(
                          color: HexColor("474672"),
                          fontFamily: "SourceSans3",
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _addWaterLog(
                              _datelog, int.parse(amountController.text));
                        },
                        child: const Text(
                          "SAVE",
                          style: TextStyle(
                            fontFamily: "SourceSans3",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.5))),
                              contentPadding: const EdgeInsets.only(bottom: 17),
                              hintStyle: TextStyle(
                                  fontFamily: "SourceSans3",
                                  color: Colors.black.withOpacity(0.5)),
                              hintText: "How much did you drink?"),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "ml",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.75),
                              fontFamily: "SourceSans3"),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 21,
                  ),
                ),
                const Text(
                  "Quick Add",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: "SourceSans3"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          amountController.text = '250';
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
                        onTap: () => amountController.text = '500',
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
                          amountController.text = '750';
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
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 28,
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Date",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        _datelog,
                        style: const TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      GestureDetector(
                          onTap: () => _showDatePicker(context),
                          child: Image.asset("res/images/sort-down.png"))
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _datelog = DateFormat('yyyy-MM-dd').format(DateTime.now());
  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    String? selectedDate;
    if (picked != null) {
      selectedDate = DateFormat('yyyy-MM-dd').format(picked);
    }
    setState(() {
      _datelog = selectedDate ?? _datelog;
    });
  }
}
