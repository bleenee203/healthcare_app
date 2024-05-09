import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<StatefulWidget> createState() => _NutritionPage();
}

class _NutritionPage extends State<NutritionPage> {
  late DateTime _datevalue;
  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          color: const Color(0xfffbedec),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 35),
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
                        "NUTRITION",
                        style: TextStyle(
                          color: HexColor("474672"),
                          fontFamily: "SourceSans3",
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      GestureDetector(
                          onTap: () => RouterCustom.router.pushNamed("foods"),
                          child: Image.asset("res/images/plus.png")),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        //onTap: () => _moveToPreviousDay(context),
                        child: Image.asset("res/images/left.png")),
                    Text(
                      DateFormat('dd/MM/yyyy').format(_datevalue),
                      style: const TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      // onTap: () => {
                      //   if (_datevalue == "Today")
                      //     {_showDatePicker(context)}
                      //   else
                      //     {_moveToNextDay(context)}
                      // },
                      child: Image.asset("res/images/right.png"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Card.filled(
                  color: HexColor("FBEDEC"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: HexColor("FBAE9E"), width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  '5460',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'in',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ],
                            ),
                            SizedBox(
                                //width: 50,
                                //height: 64,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                  CircularPercentIndicator(
                                    radius: 50,
                                    lineWidth: 6,
                                    backgroundColor: HexColor("F3F4F7"),
                                    progressColor: HexColor("BBB7EA"),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    percent: 0.4,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '5460',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'SourceSans3',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'needed',
                                        style: TextStyle(
                                            fontFamily: 'SourceSans3',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ])),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  '5460',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'SourceSans3',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'out',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Carbs',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '69g',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Protein',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '69g',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Fat',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '69g',
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Breakfast',
                    style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card.filled(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'Apple',
                      style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text(
                      '250g - 95 calo',
                      style: TextStyle(fontFamily: "SourceSans3"),
                    ),
                    trailing: Image.asset("res/images/delete.png"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Lunch',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card.filled(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'Apple',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text(
                      '250g - 95 calo',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "SourceSans3",
                      ),
                    ),
                    trailing: Image.asset("res/images/delete.png"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dinner',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card.filled(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'Apple',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SourceSans3",
                      ),
                    ),
                    subtitle: const Text(
                      '250g - 95 calo',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "SourceSans3",
                      ),
                    ),
                    trailing: Image.asset("res/images/delete.png"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Snack',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card.filled(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'Apple',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text(
                      '250g - 95 calo',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "SourceSans3",
                      ),
                    ),
                    trailing: Image.asset("res/images/delete.png"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
