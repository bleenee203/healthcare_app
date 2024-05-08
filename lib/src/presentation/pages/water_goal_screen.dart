import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: WaterGoalPage()));
}

class WaterGoalPage extends StatefulWidget {
  const WaterGoalPage({super.key});

  @override
  State<StatefulWidget> createState() => _WaterGoalPage();
}

class _WaterGoalPage extends State<WaterGoalPage> {
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
                    height: 40,
                  ),
                  Text(
                    "WATER GOAL",
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
                        RouterCustom.router.pushNamed('set-water-goal'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Daily Water Goal",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "SourceSans3"),
                        ),
                        Text(
                          "2000 ml",
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
                    textAlign: TextAlign.justify,
                    "Water is essential to good health and helps prevent  dehydration. While water needs vary from person to person, we often need at least 2000ml of water a day.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.75),
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w300),
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
