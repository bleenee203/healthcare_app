import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/models/userModel.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/userService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterSetGoalPage extends StatefulWidget {
  final int? water_target;
  const WaterSetGoalPage({super.key, this.water_target});

  @override
  State<StatefulWidget> createState() => _WaterSetGoalPage();
}

class _WaterSetGoalPage extends State<WaterSetGoalPage> {
  final TextEditingController _waterController = TextEditingController();
  final UserService userService = UserService();
  late int _water_goal;
  Future<User?> _updateUserData(newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final user = await userService.updateUserData(newData);
    if (user != null) {
      Fluttertoast.showToast(
        msg: "Set goal successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      prefs.setInt('water_goal', _water_goal);
    }
  }

  void _incrementCounter() {
    setState(() {
      _water_goal++;
      _waterController.text = _water_goal.toString();
    });
  }

  void _decrementCounter() {
    setState(() {
      _water_goal--;
      _waterController.text = _water_goal.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _water_goal = widget.water_target ?? 2000;
    _waterController.text = _water_goal.toString();
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
                    height: 100,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: _waterController,
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: const TextStyle(
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w900,
                        fontSize: 60),
                  ),
                  const Text(
                    "ml per day",
                    style: TextStyle(fontFamily: "SourceSans3", fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: _incrementCounter,
                            child: const Icon(Icons.add)),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: _decrementCounter,
                            child: const Icon(Icons.remove)),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        User data = User(
                            water_target: int.parse(_waterController.text));
                        _updateUserData(data);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor("BBB7EA")),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 88),
                        child: Text(
                          'SET GOAL',
                          style: TextStyle(
                              fontFamily: 'SourceSans3',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
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
