import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/userModel.dart';
import '../../services/userService.dart'; // Import thư viện để định dạng ngày tháng

class ExerciseGoal extends StatefulWidget {
  const ExerciseGoal({super.key});

  @override
  State<StatefulWidget> createState() => _ExerciseGoal();
}

class _ExerciseGoal extends State<ExerciseGoal>{

  int dayTarget = 0;
  int caloTarget = 0;

  String dayGoal = "0";
  String caloGoal = "0";
  TextEditingController dayTargetController = TextEditingController();
  TextEditingController caloTargetController = TextEditingController();

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

  Future<User?> _fetchUserData() async {
    final user = (await userService.fetchUserData())!;
    return user;
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final User? user = await _fetchUserData();
    if (user != null) {
      setState(() {
        dayGoal = user.exercise_day_target.toString();
        caloGoal = user.calo_burn_target.toString();
        dayTarget = user.exercise_day_target!;
        caloTarget = 1;
        dayTargetController.text = dayTarget.toString();
        caloTargetController.text = caloTarget.toString();
      });
    }
  }



  void _incrementDayTarget() {
    setState(() {
      dayTarget++;
      dayTargetController.text = dayTarget.toString();
    });
  }

  void _decrementDayTarget() {
    setState(() {
      dayTarget--;
      dayTargetController.text = dayTarget.toString();
    });
  }

  void _incrementCaloTarget() {
    setState(() {
      caloTarget++;
      caloTargetController.text = caloTarget.toString();
    });
  }

  void _decrementCaloTarget() {
    setState(() {
      caloTarget--;
      caloTargetController.text = caloTarget.toString();
    });
  }

  void _showDayTargetDialog() {
    setState(() {
      dayTargetController.text = dayTarget.toString();
    });
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Select Day Target',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0,
                          fontFamily: "SourceSans3",
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: dayTargetController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 60,
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "days per week",
                        style:
                            TextStyle(fontFamily: "SourceSans3", fontSize: 20),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: _incrementDayTarget,
                                child: const Icon(Icons.add)),
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: _decrementDayTarget,
                                child: const Icon(Icons.remove)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                dayGoal = dayTargetController.value.text;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Set Goal',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "SourceSans3",
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              dayTargetController.clear();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "SourceSans3",
                                fontSize: 20,
                                color: Colors.black,
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
          ),
        );
      },
    );
  }

  void _showCaloTargetDialog() {
    setState(() {
      caloTargetController.text = caloTarget.toString();
    });
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Select Calo Target',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0,
                          fontFamily: "SourceSans3",
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: caloTargetController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 60,
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "calos per week",
                        style:
                            TextStyle(fontFamily: "SourceSans3", fontSize: 20),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: _incrementCaloTarget,
                                child: const Icon(Icons.add)),
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: _decrementCaloTarget,
                                child: const Icon(Icons.remove)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                caloGoal = caloTargetController.value.text;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Set Goal',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "SourceSans3",
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              caloTargetController.clear();
                              caloTarget = 1;
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "SourceSans3",
                                fontSize: 20,
                                color: Colors.black,
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
          ),
        );
      },
    );
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
                          "Exercise Goal",
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
                          User data = User(
                              exercise_day_target: int.parse(dayGoal),
                              calo_burn_target: double.parse(caloGoal));
                          _updateUserData(data);
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      _showDayTargetDialog();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
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
                            "Days Exercise Target",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "$dayGoal",
                            style: const TextStyle(
                              fontFamily: "SourceSans3",
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      _showCaloTargetDialog();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
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
                            "Calos Target",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "$caloGoal",
                            style: const TextStyle(
                              fontFamily: "SourceSans3",
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
