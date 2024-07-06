import 'package:flutter/material.dart';
import 'package:healthcare_app/src/presentation/widgets/nested_tab.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<StatefulWidget> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late SharedPreferences prefs;
  late int water_target = 0;

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    initSharedPref().then((_) {
      setState(() {
        water_target = prefs.getInt('water_target')!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
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
                        "WATER",
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
                                  .pushNamed('water-goal')
                                  .then((value) => setState(() {
                                        water_target =
                                            prefs.getInt('water_target') ?? 0;
                                      })),
                              child: Image.asset("res/images/settings.png")),
                          const SizedBox(
                            width: 23,
                          ),
                          GestureDetector(
                              onTap: () => RouterCustom.router
                                  .pushNamed('water-log')
                                  .then((value) => setState(() {})),
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
                      NestedTabBar(
                        water_target: water_target,
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
