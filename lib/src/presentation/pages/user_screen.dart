import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/widgets/thum_shape.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfilePage> {
  double _currentWeightValue = 53;
  double _lastWeightValue = 49.2;
  double _targetWeightValue = 55;
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        color: const Color(0xfffbedec),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('res/images/go-back.png'),
                        Text(
                          "USER",
                          style: TextStyle(
                              color: HexColor("474672"),
                              fontFamily: "SourceSans3",
                              fontSize: 36,
                              fontWeight: FontWeight.w900),
                        ),
                        Image.asset("res/images/noti.png"),
                      ],
                    ),
                  ),
                  Card.filled(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 21, bottom: 21, left: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 102,
                            height: 102,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("res/images/avatar.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Container(
                              height: 102,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Bích Ly",
                                    style: TextStyle(
                                        fontFamily: "SourceSans3",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Age: ",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        "20",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Gender: ",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "Nữ",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Phone: ",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "0819713627",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, bottom: 22),
                    child: GestureDetector(
                      onTap: () => GoRouter.of(context).pushNamed('profile'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("res/images/circle-user-solid.png"),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 17),
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Image.asset("res/images/right.png")
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("res/images/key-solid.png"),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 17),
                          child: Text(
                            "Change password",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      Image.asset("res/images/right.png")
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, bottom: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("res/images/logout.png"),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 17),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 8),
                    child: Text(
                      "GOALS",
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset("res/images/female.png")),
                      Column(
                        children: [
                          ListTile(
                            leading:
                                Image.asset("res/images/water-glass-solid.png"),
                            title: const Row(
                              children: [
                                Text(
                                  "2000",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "ml",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              "Daily",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Image.asset("res/images/run-solid.png"),
                            title: const Row(
                              children: [
                                Text(
                                  "1000",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "steps",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              "Daily",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Image.asset(
                                "res/images/stretching-exercises-solid.png"),
                            title: const Row(
                              children: [
                                Text(
                                  "5",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "exercise days",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              "Weekly",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          ListTile(
                            leading:
                                Image.asset("res/images/location-solid.png"),
                            title: const Row(
                              children: [
                                Text(
                                  "8,05",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "km",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              "Daily",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Image.asset("res/images/sleep-solid.png"),
                            title: const Row(
                              children: [
                                Text(
                                  "8",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "hours",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              "Daily",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          ListTile(
                            leading:
                                Image.asset("res/images/calories-solid.png"),
                            title: const Row(
                              children: [
                                Text(
                                  "1.922",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "cal",
                                  style: TextStyle(
                                    fontFamily: "SourceSans3",
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              "Daily",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 100),
                    child: _lastWeightValue > _targetWeightValue
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _targetWeightValue.toStringAsFixed(1) + "kg",
                                style: TextStyle(
                                    fontFamily: "SourceSans3", fontSize: 20),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: const SliderThemeData(
                                      showValueIndicator:
                                          ShowValueIndicator.never,
                                      thumbShape: ThumbShape()),
                                  child: Slider(
                                    value: _currentWeightValue,
                                    min: _targetWeightValue,
                                    max: _lastWeightValue,
                                    divisions: null,
                                    activeColor: HexColor("FBAE9E"),
                                    inactiveColor: Colors.white,
                                    label:
                                        _currentWeightValue.toStringAsFixed(1),
                                    onChanged: (double value) => {
                                      setState(() {
                                        _currentWeightValue = value;
                                      })
                                    },
                                  ),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          color: HexColor("FBEDEC"),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: HexColor("72D756"),
                                              width: 1))),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        _lastWeightValue.toStringAsFixed(1) +
                                            "kg",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _lastWeightValue.toStringAsFixed(1) + "kg",
                                style: TextStyle(
                                    fontFamily: "SourceSans3", fontSize: 20),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: const SliderThemeData(
                                      showValueIndicator:
                                          ShowValueIndicator.never,
                                      thumbShape: ThumbShape()),
                                  child: Slider(
                                    value: _currentWeightValue,
                                    min: _lastWeightValue,
                                    max: _targetWeightValue,
                                    divisions: null,
                                    activeColor: HexColor("FBAE9E"),
                                    inactiveColor: Colors.white,
                                    label:
                                        _currentWeightValue.toStringAsFixed(1),
                                    onChanged: (double value) => {
                                      setState(() {
                                        _currentWeightValue = value;
                                      })
                                    },
                                  ),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          color: HexColor("FBEDEC"),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: HexColor("72D756"),
                                              width: 1))),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        _targetWeightValue.toStringAsFixed(1) +
                                            "kg",
                                        style: TextStyle(
                                            fontFamily: "SourceSans3",
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  )
                ])),
      )
    ]);
  }
}
