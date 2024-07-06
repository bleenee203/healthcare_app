import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/drinkService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalityPage extends StatefulWidget {
  const PersonalityPage({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalityPage();
}

class _PersonalityPage extends State<PersonalityPage> {
  late SharedPreferences prefs;
  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  int water_target = 0;
  Future<Map<String, dynamic>> _fetchDrink(String date) async {
    Map<String, dynamic>? drinkToday;
    DrinkService drinkService = DrinkService();

    if (date == "Today") {
      DateTime today = DateTime.now();
      final Map<String, dynamic> response =
          await drinkService.fetchDrink(DateFormat('yyyy-MM-dd').format(today));
      if (response.isEmpty) {
        return {};
      }
      final List<Map<String, dynamic>> drinks = response['drinks'] ?? [];
      drinkToday = drinks.firstWhere(
          (drink) => drink['date'] == DateFormat('dd/MM/yyyy').format(today),
          orElse: () => {});
    } else if (date == "Yesterday") {
      DateTime today = DateTime.now().subtract(Duration(days: 1));
      final Map<String, dynamic> response =
          await drinkService.fetchDrink(DateFormat('yyyy-MM-dd').format(today));
      if (response.isEmpty) {
        return {};
      }
      final List<Map<String, dynamic>> drinks = response['drinks'] ?? [];
      drinkToday = drinks.firstWhere(
          (drink) => drink['date'] == DateFormat('dd/MM/yyyy').format(today),
          orElse: () => {});
    } else {
      DateTime today = DateFormat('dd/MM/yyyy').parse(date);
      final Map<String, dynamic> response =
          await drinkService.fetchDrink(DateFormat('yyyy-MM-dd').format(today));
      if (response.isEmpty) {
        return {};
      }
      final List<Map<String, dynamic>> drinks = response['drinks'] ?? [];
      drinkToday =
          drinks.firstWhere((drink) => drink['date'] == date, orElse: () => {});
      print(drinks);
      print(date);
    }
    return {'drinkToday': drinkToday};
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref().then((_) {
      setState(() {
        water_target = prefs.getInt('water_target')!;
      });
    });
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
                        "PERSONALITY",
                        style: TextStyle(
                          color: HexColor("474672"),
                          fontFamily: "SourceSans3",
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Image.asset("res/images/noti.png"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => _moveToPreviousDay(context),
                        child: Image.asset("res/images/left.png")),
                    Text(
                      _datevalue,
                      style: const TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        if (_datevalue == "Today")
                          {_showDatePicker(context)}
                        else
                          {_moveToNextDay(context)}
                      },
                      child: Image.asset(
                        _datevalue != "Today"
                            ? "res/images/right.png"
                            : "res/images/edit.png",
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 33,
                ),
                SizedBox(
                    child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    child: CircularPercentIndicator(
                      radius: 67,
                      lineWidth: 6,
                      backgroundColor: HexColor("F3F4F7"),
                      progressColor: HexColor("FDBCA5"),
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: 0.4,
                    ),
                  ),
                  Image.asset("res/images/running-shoes.png")
                ])),
                const SizedBox(height: 17),
                Column(
                  children: [
                    const Text(
                      "5470",
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Steps",
                      style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            child: Stack(
                                fit: StackFit.loose,
                                alignment: Alignment.center,
                                children: [
                              Positioned(
                                child: CircularPercentIndicator(
                                  radius: 39,
                                  lineWidth: 6,
                                  backgroundColor: HexColor("F3F4F7"),
                                  progressColor: HexColor("FDBCA5"),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  percent: 0.4,
                                ),
                              ),
                              Image.asset("res/images/location.png")
                            ])),
                        const Text(
                          "5",
                          style: TextStyle(
                            fontFamily: "SourceSans3",
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "km",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                            child: Stack(
                                fit: StackFit.loose,
                                alignment: Alignment.center,
                                children: [
                              Positioned(
                                child: CircularPercentIndicator(
                                  radius: 39,
                                  lineWidth: 6,
                                  backgroundColor: HexColor("F3F4F7"),
                                  progressColor: HexColor("FDBCA5"),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  percent: 0.4,
                                ),
                              ),
                              Image.asset("res/images/fire.png")
                            ])),
                        const Text(
                          "560",
                          style: TextStyle(
                            fontFamily: "SourceSans3",
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "calories",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 34,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Sleep",
                    style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => RouterCustom.router.pushNamed('sleep'),
                  child: Card.filled(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sleep duration",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "8",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SourceSans3",
                                  fontSize: 36,
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "h",
                                    style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  child: Stack(
                                      fit: StackFit.loose,
                                      alignment: Alignment.center,
                                      children: [
                                    Positioned(
                                      child: CircularPercentIndicator(
                                        radius: 30,
                                        lineWidth: 6,
                                        backgroundColor: HexColor("F3F4F7"),
                                        progressColor: HexColor("BBB7EA"),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        percent: 0.4,
                                      ),
                                    ),
                                    Image.asset("res/images/moon.png")
                                  ])),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Today",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 43,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Water",
                    style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => RouterCustom.router.pushNamed('water').then((_) {
                    setState(() {});
                  }),
                  child: Card.filled(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Water amount",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<Map<String, dynamic>>(
                                  future: _fetchDrink(_datevalue),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Map<String, dynamic>>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text(
                                        'No data',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SourceSans3",
                                          fontSize: 36,
                                        ),
                                      );
                                    } else {
                                      final Map<String, dynamic> drink =
                                          (snapshot.data!['drinkToday']
                                              as Map<String, dynamic>);
                                      return Text(
                                        "${drink['totalAmount']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SourceSans3",
                                          fontSize: 36,
                                        ),
                                      );
                                    }
                                  }),
                              SizedBox(
                                  child: Stack(
                                      fit: StackFit.loose,
                                      alignment: Alignment.center,
                                      children: [
                                    Positioned(
                                      child: FutureBuilder<
                                              Map<String, dynamic>>(
                                          future: _fetchDrink(_datevalue),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<
                                                      Map<String, dynamic>>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.isEmpty) {
                                              return CircularPercentIndicator(
                                                radius: 30,
                                                lineWidth: 6,
                                                backgroundColor:
                                                    HexColor("F3F4F7"),
                                                progressColor:
                                                    HexColor("BBB7EA"),
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                percent: 0,
                                              );
                                            } else {
                                              final Map<String, dynamic> drink =
                                                  (snapshot.data!['drinkToday']
                                                      as Map<String, dynamic>);
                                              return CircularPercentIndicator(
                                                radius: 30,
                                                lineWidth: 6,
                                                backgroundColor:
                                                    HexColor("F3F4F7"),
                                                progressColor:
                                                    HexColor("BBB7EA"),
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                percent: drink['totalAmount'] <=
                                                        water_target
                                                    ? drink['totalAmount'] /
                                                        water_target
                                                    : 1,
                                              );
                                            }
                                          }),
                                    ),
                                    Image.asset("res/images/glass.png")
                                  ])),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            _datevalue,
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 43,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Activity",
                    style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => RouterCustom.router.pushNamed('exercise'),
                  child: Card.filled(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Excercise days",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "0",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SourceSans3",
                                  fontSize: 36,
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "of",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              const Expanded(
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SourceSans3",
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                              _buildContainer(false, "M"),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildContainer(false, "T"),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildContainer(false, "w"),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildContainer(true, "T"),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildContainer(true, "F"),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildContainer(false, "S"),
                              const SizedBox(
                                width: 5,
                              ),
                              _buildContainer(false, "S")
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "This week",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(bool check, String dayname) {
    return Column(
      children: [
        Container(
          width: 15,
          height: 41,
          decoration: BoxDecoration(
            color: check
                ? HexColor("908BD5")
                : HexColor("BBB7EA"), // Đổi màu khi check
            borderRadius: BorderRadius.circular(20),
          ),
          child: check
              ? const Icon(Icons.check_rounded,
                  color: Colors.white, size: 16) // Thêm icon khi check
              : null,
        ),
        Text(
          dayname,
          style: TextStyle(
              fontFamily: "SourceSans3",
              fontSize: 16,
              color: Colors.black.withOpacity(0.5)),
        ),
      ],
    );
  }

  String _datevalue = "Today";
  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    String? selectedDate;
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));
    if (picked != null) {
      selectedDate = DateFormat('dd/MM/yyyy').format(picked);
      if (picked.day == today.day &&
          picked.month == today.month &&
          picked.year == today.year) {
        selectedDate = "Today";
      }
      if (picked.day == yesterday.day &&
          picked.month == yesterday.month &&
          picked.year == yesterday.year) {
        selectedDate = "Yesterday";
      }
    }
    setState(() {
      _datevalue = selectedDate ?? "Today";
    });
  }

  void _moveToPreviousDay(BuildContext context) {
    DateTime currentDate;
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (_datevalue == "Today") {
      currentDate = (DateTime.now());
    } else if (_datevalue == "Yesterday") {
      currentDate = (DateTime.now().subtract(const Duration(days: 1)));
    } else {
      currentDate = DateFormat('dd/MM/yyyy').parse(_datevalue);
    }
    String previousDate = DateFormat('dd/MM/yyyy')
        .format(currentDate.subtract(const Duration(days: 1)));
    if (currentDate.subtract(const Duration(days: 1)).day == yesterday.day &&
        currentDate.subtract(const Duration(days: 1)).month ==
            yesterday.month &&
        currentDate.subtract(const Duration(days: 1)).year == yesterday.year) {
      previousDate = "Yesterday";
    }
    setState(() {
      _datevalue = previousDate;
    });
  }

  void _moveToNextDay(BuildContext context) {
    DateTime currentDate;
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (_datevalue == "Today") {
      currentDate = (DateTime.now());
    } else if (_datevalue == "Yesterday") {
      currentDate = (DateTime.now().subtract(const Duration(days: 1)));
    } else {
      currentDate = DateFormat('dd/MM/yyyy').parse(_datevalue);
    }
    String nextDate = DateFormat('dd/MM/yyyy')
        .format(currentDate.add(const Duration(days: 1)));
    if (currentDate.add(const Duration(days: 1)).day == yesterday.day &&
        currentDate.add(const Duration(days: 1)).month == yesterday.month &&
        currentDate.add(const Duration(days: 1)).year == yesterday.year) {
      nextDate = "Yesterday";
    }
    if (currentDate.day == yesterday.day &&
        currentDate.month == yesterday.month &&
        currentDate.year == yesterday.year) {
      nextDate = "Today";
    }
    setState(() {
      _datevalue = nextDate;
    });
  }
}
