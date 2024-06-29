import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/foodService.dart';
import 'package:healthcare_app/src/services/mealServices.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<StatefulWidget> createState() => _NutritionPage();
}

class _NutritionPage extends State<NutritionPage> {
  late DateTime _datevalue;
  final MealService mealService = MealService();
  final FoodService foodService = FoodService();
  double calorieIn = 0;
  double calorieOut = 0;
  double calorieNeeded = 0;
  double calorieTarget = 0;
  double carbs = 0;
  double protein = 0;
  double fat = 0;
  double percent = 0;
  late SharedPreferences prefs;

  Future<List<Map<String, dynamic>>> _fetchfoodofmeal(String date) async {
    final List<Map<String, dynamic>> meals = await mealService.fetchMeal(date);
    return meals;
  }

  Future<void> _updateCalorie(String date) async {
    final meals = await _fetchfoodofmeal(date);
    double totalCalories = meals.fold(0.0, (sum, meal) {
      double kcal = meal['kcal'].toDouble();
      print('kcal: $kcal');
      return sum + kcal;
    });
    double totalfat = meals.fold(0.0, (sum, meal) {
      double fat = (meal['fat']?.toDouble() ?? 0);
      return sum + fat;
    });
    double totalprotein = meals.fold(0.0, (sum, meal) {
      double protein = (meal['protein']?.toDouble() ?? 0);
      return sum + protein;
    });
    double totalcarbs = meals.fold(0.0, (sum, meal) {
      double carbs = (meal['carbs']?.toDouble() ?? 0);
      return sum + carbs;
    });

    setState(() {
      calorieIn = totalCalories;
      calorieNeeded = prefs.getDouble('calo_target')! - calorieIn + calorieOut;
      percent = calculatePercent(calorieNeeded, calorieTarget);
      carbs = totalcarbs;
      protein = totalprotein;
      fat = totalfat;
    });
  }

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
    initSharedPref().then((_) {
      calorieTarget = prefs.getDouble('calo_target')!;
      _updateCalorie(DateFormat('dd/MM/yyyy').format(_datevalue));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _removeFood(String id, double kcal, double? xcarbs, double? xfat,
      double? xprotein) async {
    try {
      bool? isDeleted = await mealService.removeFood(id);
      if (isDeleted == true) {
        Fluttertoast.showToast(
          msg: "Remove food successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        setState(() {
          calorieIn = calorieIn - kcal;
          calorieNeeded =
              prefs.getDouble('calo_target')! - calorieIn + calorieOut;
          carbs = carbs - (xcarbs ?? 0);
          protein = protein - (xprotein ?? 0);
          fat = fat - (xfat ?? 0);
          percent = calculatePercent(calorieNeeded, calorieTarget);
        });
      }
    } catch (error) {
      print(error);
    }
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
                            onTap: () => RouterCustom.router
                                .pushNamed('foods')
                                .then((value) => setState(() {
                                      _updateCalorie(DateFormat('dd/MM/yyyy')
                                          .format(_datevalue));
                                    })),
                            child: Image.asset("res/images/plus.png")),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _moveToPreviousDay(context);
                            //setState(() {
                            _updateCalorie(
                                DateFormat('dd/MM/yyyy').format(_datevalue));
                            //});
                          },
                          child: Image.asset("res/images/left.png")),
                      Text(
                        getDisplayText(_datevalue),
                        style: const TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: _datevalue.day == DateTime.now().day
                            ? null
                            : () {
                                _moveToNextDay(context);
                                _updateCalorie(DateFormat('dd/MM/yyyy')
                                    .format(_datevalue));
                              },
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
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        calorieIn.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'SourceSans3',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'in',
                                        style: TextStyle(
                                            fontFamily: 'SourceSans3',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: SizedBox(
                                    //width: 50,
                                    //height: 64,
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                      percent == -1
                                          ? CircularPercentIndicator(
                                              radius: 60,
                                              lineWidth: 6,
                                              backgroundColor: Colors.red,
                                              progressColor: HexColor("BBB7EA"),
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              percent: percent >= 0.0
                                                  ? percent
                                                  : 0.0,
                                            )
                                          : CircularPercentIndicator(
                                              radius: 60,
                                              lineWidth: 6,
                                              backgroundColor:
                                                  HexColor("F3F4F7"),
                                              progressColor: HexColor("BBB7EA"),
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              percent: percent >= 0.0
                                                  ? percent
                                                  : 0.0,
                                            ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            calorieNeeded.toString(),
                                            style: const TextStyle(
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
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ])),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        calorieOut.toString(),
                                        style: const TextStyle(
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
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'Carbs',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "SourceSans3",
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '$carbs',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "SourceSans3",
                                        color: HexColor("F06244"),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Protein',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "SourceSans3",
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '$protein',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: HexColor("F06244"),
                                        fontFamily: "SourceSans3",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Fat',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "SourceSans3",
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '$fat',
                                    style: TextStyle(
                                        color: HexColor("F06244"),
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
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchfoodofmeal(
                          DateFormat('dd/MM/yyyy').format(_datevalue)),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 1,
                            height: 1,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                  fontFamily: 'SourceSans3', fontSize: 24),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: SizedBox(
                              height: 1,
                            ),
                          );
                        } else {
                          List<Map<String, dynamic>> meals = snapshot.data!
                              .where((meal) => meal['meal_type'] == 'Breakfast')
                              .toList();

                          return ListView(
                            shrinkWrap: true,
                            children: meals.map((meal) {
                              double ration = meal['ration'].toDouble() ?? 0;
                              double amount = meal['amount'].toDouble();
                              ration = ration * amount;
                              return Column(
                                children: [
                                  Card.filled(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        meal['food_name'],
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${ration.toString()}g - ${meal['kcal']}cal',
                                        style: const TextStyle(
                                            fontFamily: "SourceSans3"),
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            _removeFood(
                                                meal['_id'],
                                                meal['kcal'].toDouble(),
                                                meal['carbs']?.toDouble(),
                                                meal['fat']?.toDouble(),
                                                meal['protein']?.toDouble());
                                          },
                                          child: Image.asset(
                                              "res/images/delete.png")),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 8.0), // Khoảng cách giữa các Card
                                ],
                              );
                            }).toList(),
                          );
                        }
                      }),
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
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchfoodofmeal(
                          DateFormat('dd/MM/yyyy').format(_datevalue)),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 1,
                            height: 1,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                  fontFamily: 'SourceSans3', fontSize: 24),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: SizedBox(
                              height: 1,
                            ),
                          );
                        } else {
                          List<Map<String, dynamic>> meals = snapshot.data!
                              .where((meal) => meal['meal_type'] == 'Lunch')
                              .toList();

                          return ListView(
                            shrinkWrap: true,
                            children: meals.map((meal) {
                              double ration = meal['ration'].toDouble() ?? 0;
                              double amount = meal['amount'].toDouble();
                              ration = ration * amount;
                              return Column(
                                children: [
                                  Card.filled(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        meal['food_name'],
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${ration.toString()}g - ${meal['kcal']}cal',
                                        style: const TextStyle(
                                            fontFamily: "SourceSans3"),
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            _removeFood(
                                                meal['_id'],
                                                meal['kcal'].toDouble(),
                                                meal['carbs']?.toDouble(),
                                                meal['fat']?.toDouble(),
                                                meal['protein']?.toDouble());
                                          },
                                          child: Image.asset(
                                              "res/images/delete.png")),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 8.0), // Khoảng cách giữa các Card
                                ],
                              );
                            }).toList(),
                          );
                        }
                      }),
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
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchfoodofmeal(
                          DateFormat('dd/MM/yyyy').format(_datevalue)),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 1,
                            height: 1,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                  fontFamily: 'SourceSans3', fontSize: 24),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: SizedBox(
                              height: 1,
                            ),
                          );
                        } else {
                          List<Map<String, dynamic>> meals = snapshot.data!
                              .where((meal) => meal['meal_type'] == 'Dinner')
                              .toList();

                          return ListView(
                            shrinkWrap: true,
                            children: meals.map((meal) {
                              double ration = meal['ration'].toDouble() ?? 0;
                              double amount = meal['amount'].toDouble();
                              ration = ration * amount;
                              return Column(
                                children: [
                                  Card.filled(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        meal['food_name'],
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${ration.toString()}g - ${meal['kcal']}cal',
                                        style: const TextStyle(
                                            fontFamily: "SourceSans3"),
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            _removeFood(
                                                meal['_id'],
                                                meal['kcal'].toDouble(),
                                                meal['carbs']?.toDouble(),
                                                meal['fat']?.toDouble(),
                                                meal['protein']?.toDouble());
                                          },
                                          child: Image.asset(
                                              "res/images/delete.png")),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 8.0), // Khoảng cách giữa các Card
                                ],
                              );
                            }).toList(),
                          );
                        }
                      }),
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
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchfoodofmeal(
                          DateFormat('dd/MM/yyyy').format(_datevalue)),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 1,
                            height: 1,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                  fontFamily: 'SourceSans3', fontSize: 24),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: SizedBox(
                              height: 1,
                            ),
                          );
                        } else {
                          List<Map<String, dynamic>> meals = snapshot.data!
                              .where((meal) => meal['meal_type'] == 'Snack')
                              .toList();

                          return ListView(
                            shrinkWrap: true,
                            children: meals.map((meal) {
                              double ration = meal['ration'].toDouble() ?? 0;
                              double amount = meal['amount'].toDouble();
                              ration = ration * amount;
                              return Column(
                                children: [
                                  Card.filled(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        meal['food_name'],
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${ration.toString()}g - ${meal['kcal']}cal',
                                        style: const TextStyle(
                                            fontFamily: "SourceSans3"),
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            _removeFood(
                                                meal['_id'],
                                                meal['kcal'].toDouble(),
                                                meal['carbs']?.toDouble(),
                                                meal['fat']?.toDouble(),
                                                meal['protein']?.toDouble());
                                          },
                                          child: Image.asset(
                                              "res/images/delete.png")),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 8.0), // Khoảng cách giữa các Card
                                ],
                              );
                            }).toList(),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )))),
    );
  }

  String getDisplayText(DateTime date) {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (date.day == today.day &&
        date.month == today.month &&
        date.year == today.year) {
      return "Today";
    } else if (date.day == yesterday.day &&
        date.month == yesterday.month &&
        date.year == yesterday.year) {
      return "Yesterday";
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  void _moveToPreviousDay(BuildContext context) {
    DateTime previousDate = _datevalue.subtract(const Duration(days: 1));
    setState(() {
      _datevalue = previousDate;
    });
    print(_datevalue);
  }

  void _moveToNextDay(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime nextDate = DateTime.now();
    if (!(_datevalue.year == now.year &&
        _datevalue.month == now.month &&
        _datevalue.day == now.day)) {
      nextDate = _datevalue.add(const Duration(days: 1));
    }
    setState(() {
      _datevalue = nextDate;
    });
  }

  double calculatePercent(double calorieNeeded, double? calorieTarget) {
    if (calorieNeeded > 0) {
      double percent = (calorieTarget! - calorieNeeded) / calorieTarget;
      return percent.clamp(0.0, 1.0);
    }
    return -1;
  }
}
