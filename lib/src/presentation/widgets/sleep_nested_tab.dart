import 'package:flutter/material.dart';
import 'package:healthcare_app/src/presentation/widgets/threemonth_sleep_tab.dart';
import 'package:healthcare_app/src/presentation/widgets/week_sleep_tab.dart';
import 'package:healthcare_app/src/presentation/widgets/year_sleep_tab.dart';
import 'package:hexcolor/hexcolor.dart';

import 'month_sleep_tab.dart';

class sleepNestedTabBar extends StatefulWidget {
  const sleepNestedTabBar({super.key});
  @override
  _sleepNestedTabBarState createState() => _sleepNestedTabBarState();
}

class _sleepNestedTabBarState extends State<sleepNestedTabBar>
    with TickerProviderStateMixin {
  late DateTime _datevalue;
  List<DateTime> initDayOfWeek(DateTime day) {
    List<DateTime> daysOfWeek = [];
    DateTime mondayOfThisWeek = day.subtract(
        Duration(days: day.weekday - 1)); // Lùi lại đến thứ Hai của tuần này

    // Generating days from today to Monday of this week
    if (day.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      for (DateTime i = day;
      i.isAfter(mondayOfThisWeek) || i.isAtSameMomentAs(mondayOfThisWeek);
      i = i.subtract(const Duration(days: 1))) {
        //String formattedDay = DateFormat('EEEE, d MMMM yyyy').format(day);
        daysOfWeek.add(i);
      }
      daysOfWeek.addAll(initDayOfWeek(
          daysOfWeek[daysOfWeek.length - 1].subtract(const Duration(days: 1))));
    } else {
      for (DateTime i = day;
      i.isAfter(mondayOfThisWeek) || i.isAtSameMomentAs(mondayOfThisWeek);
      i = i.subtract(const Duration(days: 1))) {
        //String formattedDay = DateFormat('EEEE, d MMMM yyyy').format(day);
        daysOfWeek.add(i);
      }
    }

    return daysOfWeek;
  }

  final _scrollController = ScrollController();

  // Dummy list of items
  List<DateTime> listDay = [];
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _datevalue = DateTime.now();
    _nestedTabController = TabController(length: 4, vsync: this);
    listDay = initDayOfWeek(DateTime.now().subtract(const Duration(days: 1)));
    _scrollController.addListener(_loadMoreItems);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
    _scrollController.dispose();
  }

  // Function to simulate loading more items
  Future<void> _loadMoreItems() async {
    // Trigger loading more items when reaching the end of the list
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Simulating a delay of 1 second
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        listDay.addAll(initDayOfWeek(
            listDay[listDay.length - 1].subtract(const Duration(days: 1))));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_datevalue);
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: HexColor("474672"),
          labelColor: HexColor("474672"),
          unselectedLabelColor: Colors.black,
          //isScrollable: true,
          tabs: const <Widget>[
            Tab(
              child: Text(
                "WEEK",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Tab(
              child: Text(
                "MONTH",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Tab(
              child: Text(
                "3 MONTH",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Tab(
              child: Text(
                "YEAR",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TabBarView(
            controller: _nestedTabController,
            children: const <Widget>[
              WeekSleepTab(),
              MonthSleepTab(),
              ThreeMonthSleepTab(),
              YearSleepTab()
            ],
          ),
        )
      ],
    );
  }
}
