
import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class SleepSetStartPage extends StatefulWidget {
  const SleepSetStartPage({super.key});

  @override
  State<StatefulWidget> createState() => _SleepSetStartPage();
}

class _SleepSetStartPage extends State<SleepSetStartPage> {
  int _sleepHours = 0;
  int _sleepMin = 0;

  final FixedExtentScrollController _hoursController =
  FixedExtentScrollController(initialItem: 0);
  final FixedExtentScrollController _minutesController =
  FixedExtentScrollController(initialItem: 0);

  void _centerItem(FixedExtentScrollController controller, int itemCount) {
    final int selectedItem = controller.selectedItem;
    setState(() {
      if (itemCount == 24) {
        _sleepHours = selectedItem % itemCount;
      }
      else {
        _sleepMin = selectedItem %60;
      }
    });
    controller.animateToItem(
      selectedItem,
      duration: const Duration(milliseconds: 30),
      curve: Curves.easeInOut,
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
                          "SLEEP",
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: NotificationListener<ScrollEndNotification>(
                              onNotification: (notification) {
                                _centerItem(_hoursController, 24);
                                                              return true;
                              },
                              child: ListWheelScrollView.useDelegate(
                                controller: _hoursController,
                                itemExtent: 120,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _sleepHours = index % 24;
                                  });
                                },
                                childDelegate: ListWheelChildLoopingListDelegate(
                                  children: List<Widget>.generate(24, (int index) {
                                    return Center(
                                      child: Text(
                                        (index % 24).toString(),
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontWeight: FontWeight.w900,
                                          fontSize: 60,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Hours",
                            style: TextStyle(fontFamily: "SourceSans3", fontSize: 20),
                          ),
                        ],
                      ),
                      const Text(
                        "-",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontSize: 90,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: NotificationListener<ScrollEndNotification>(
                              onNotification: (notification) {
                                _centerItem(_minutesController, 60);
                                                              return true;
                              },
                              child: ListWheelScrollView.useDelegate(
                                controller: _minutesController,
                                itemExtent: 120,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _sleepMin = index % 60;
                                  });
                                },
                                childDelegate: ListWheelChildLoopingListDelegate(
                                  children: List<Widget>.generate(60, (int index) {
                                    return Center(
                                      child: Text(
                                        (index % 60).toString(),
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontWeight: FontWeight.w900,
                                          fontSize: 60,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Minutes",
                            style: TextStyle(fontFamily: "SourceSans3", fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(344, 60),
                        padding: const EdgeInsets.fromLTRB(68, 16, 68, 16),
                        backgroundColor: const Color(0xFF474672),
                      ),
                      onPressed: () {
                        print("${_hoursController.selectedItem%24} - ${_minutesController.selectedItem%60}");
                        // Handle set goal
                      },
                      child: const Text('SET GOAL', style: TextStyle(
                        color: Colors.white,
                        fontFamily: "SourceSans3",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
