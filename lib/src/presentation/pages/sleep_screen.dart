import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/sleep_nested_tab.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<StatefulWidget> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late SharedPreferences prefs;
  late int sleep_target = 0;

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    initSharedPref().then((_) {
      setState(() {
        sleep_target = prefs.getInt('sleep_target')!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _showSleepDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: -10,
              right: -40,
              child: Dialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                backgroundColor: const Color(0xFFD4A7C7),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  RouterCustom.router.pushNamed('sleep-log');
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Add Sleep Log',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SourceSans3",
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  RouterCustom.router
                                      .pushNamed('set-wake-time');
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Begin Sleep Now',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SourceSans3",
                                    fontSize: 18,
                                    color: Colors.black,
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
            ),
          ],
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
          height: double.infinity,
          width: double.infinity,
          color: const Color(0xfffbedec),
          //physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 32, left: 20, right: 20),
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
                        "SLEEP",
                        style: TextStyle(
                          color: HexColor("474672"),
                          fontFamily: "SourceSans3",
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () => RouterCustom.router
                                  .pushNamed('sleep-goal')
                                  .then((value) => setState(() {
                                        sleep_target =
                                            prefs.getInt('water_target') ?? 0;
                                      })),
                              child: Image.asset("res/images/settings.png")),
                          const SizedBox(
                            width: 23,
                          ),
                          GestureDetector(
                              onTap: _showSleepDialog,
                              child: Image.asset("res/images/plus.png")),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: sleepNestedTabBar(
                          sleep_target: sleep_target,
                        ),
                      ),
                    ],
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
