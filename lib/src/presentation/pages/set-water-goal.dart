import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class WaterSetGoalPage extends StatefulWidget {
  const WaterSetGoalPage({super.key});

  @override
  State<StatefulWidget> createState() => _WaterSetGoalPage();
}

class _WaterSetGoalPage extends State<WaterSetGoalPage> {
  int _water_goal = 2000;
  void _incrementCounter() {
    setState(() {
      _water_goal++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _water_goal--;
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
                  Text(
                    '$_water_goal',
                    style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w900,
                        fontSize: 60),
                  ),
                  Text(
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
                            child: Icon(Icons.add)),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: _decrementCounter,
                            child: Icon(Icons.remove)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
