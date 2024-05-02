import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  List<WaterPoint> points = [
    WaterPoint(0, 1600), // Điểm giá có x = 0 và y = 5
    WaterPoint(1, 1000), // Điểm giá có x = 1 và y = 8
    WaterPoint(2),
    WaterPoint(3),
    WaterPoint(4),
    WaterPoint(5),
    WaterPoint(6),
    // Thêm các điểm giá khác tại đây...
  ];
  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TabBar(
            controller: _nestedTabController,
            indicatorColor: HexColor("474672"),
            labelColor: HexColor("474672"),
            unselectedLabelColor: Colors.black,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "WEEK",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "MONTH",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "3 MONTH",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "YEAR",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            height: screenHeight * 0.70,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              //onTap: () => _moveToPreviousDay(context),
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
                            //onTap: () => _moveToNextDay(context),
                            child: Image.asset("res/images/right.png"),
                          )
                        ],
                      ),
                      Text(
                        "2000ml (avg)",
                        style: TextStyle(
                          color: HexColor("474672").withOpacity(0.5),
                          fontFamily: "SourceSans3",
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 78,
                      ),
                      BarChartWidget(points: points),
                      const SizedBox(
                        height: 23,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Quick Add For Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset("res/images/glass-of-water.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 glass",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(250 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(500 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/super_bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 super bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(750 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset("res/images/glass-of-water.png"),
                          Text(
                            "1000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml of your ",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "2000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml goal",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th5",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th4",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th3",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th2",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              //onTap: () => _moveToPreviousDay(context),
                              child: Image.asset("res/images/left.png")),
                          Text(
                            "This month",
                            style: const TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            //onTap: () => _moveToNextDay(context),
                            child: Image.asset("res/images/right.png"),
                          )
                        ],
                      ),
                      Text(
                        "2000ml (avg)",
                        style: TextStyle(
                          color: HexColor("474672").withOpacity(0.5),
                          fontFamily: "SourceSans3",
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 78,
                      ),
                      BarChartWidget(points: points),
                      const SizedBox(
                        height: 23,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Quick Add For Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset("res/images/glass-of-water.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 glass",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(250 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(500 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/super_bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 super bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(750 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset("res/images/glass-of-water.png"),
                          Text(
                            "1000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml of your ",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "2000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml goal",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th5",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th4",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th3",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th2",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: HexColor("BBB7EA")),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Last week",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "SourceSans3"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CN  ",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th7",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th6",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th5",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th4",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th3",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th2",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              //onTap: () => _moveToPreviousDay(context),
                              child: Image.asset("res/images/left.png")),
                          Text(
                            "February - April",
                            style: const TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            //onTap: () => _moveToNextDay(context),
                            child: Image.asset("res/images/right.png"),
                          )
                        ],
                      ),
                      Text(
                        "2000ml (avg)",
                        style: TextStyle(
                          color: HexColor("474672").withOpacity(0.5),
                          fontFamily: "SourceSans3",
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 78,
                      ),
                      BarChartWidget(points: points),
                      const SizedBox(
                        height: 23,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Quick Add For Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset("res/images/glass-of-water.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 glass",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(250 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(500 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/super_bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 super bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(750 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset("res/images/glass-of-water.png"),
                          Text(
                            "1000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml of your ",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "2000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml goal",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th5",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th4",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th3",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th2",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: HexColor("BBB7EA")),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Last week",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "SourceSans3"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CN  ",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th7",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th6",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th5",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th4",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th3",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th2",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              //onTap: () => _moveToPreviousDay(context),
                              child: Image.asset("res/images/left.png")),
                          Text(
                            "2024",
                            style: const TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            //onTap: () => _moveToNextDay(context),
                            child: Image.asset("res/images/right.png"),
                          )
                        ],
                      ),
                      Text(
                        "2000ml (avg)",
                        style: TextStyle(
                          color: HexColor("474672").withOpacity(0.5),
                          fontFamily: "SourceSans3",
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 78,
                      ),
                      BarChartWidget(points: points),
                      const SizedBox(
                        height: 23,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Quick Add For Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset("res/images/glass-of-water.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 glass",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(250 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(500 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("res/images/super_bottle.png"),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                "1 super bottle",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "(750 ml)",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.75)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Today",
                          style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset("res/images/glass-of-water.png"),
                          Text(
                            "1000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml of your ",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "2000",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ml goal",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 16,
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th5",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th4",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th3",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th2",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: HexColor("BBB7EA")),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Last week",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "SourceSans3"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CN  ",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th7",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th6",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th5",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th4",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th3",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Th2",
                            style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              "2000ml",
                              style: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset("res/images/target.png")
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _datevalue = "This week";
  void _moveToPreviousDay(BuildContext context) {
    DateTime currentDate;
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    if (_datevalue == "Today") {
      currentDate = (DateTime.now());
    } else if (_datevalue == "Yesterday") {
      currentDate = (DateTime.now().subtract(Duration(days: 1)));
    } else {
      currentDate = DateFormat('dd/MM/yyyy').parse(_datevalue);
    }
    String previousDate = DateFormat('dd/MM/yyyy')
        .format(currentDate.subtract(Duration(days: 1)));
    if (currentDate.subtract(Duration(days: 1)).day == yesterday.day &&
        currentDate.subtract(Duration(days: 1)).month == yesterday.month &&
        currentDate.subtract(Duration(days: 1)).year == yesterday.year) {
      previousDate = "Yesterday";
    }
    setState(() {
      _datevalue = previousDate;
    });
  }

  void _moveToNextDay(BuildContext context) {
    DateTime currentDate;
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    if (_datevalue == "Today") {
      currentDate = (DateTime.now());
    } else if (_datevalue == "Yesterday") {
      currentDate = (DateTime.now().subtract(Duration(days: 1)));
    } else {
      currentDate = DateFormat('dd/MM/yyyy').parse(_datevalue);
    }
    String nextDate =
        DateFormat('dd/MM/yyyy').format(currentDate.add(Duration(days: 1)));
    if (currentDate.add(Duration(days: 1)).day == yesterday.day &&
        currentDate.add(Duration(days: 1)).month == yesterday.month &&
        currentDate.add(Duration(days: 1)).year == yesterday.year) {
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
