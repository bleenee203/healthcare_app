import 'package:flutter/material.dart';
import 'package:healthcare_app/src/presentation/widgets/month_exercise_tab.dart';
import 'package:healthcare_app/src/presentation/widgets/week_exercise_tab.dart';
import 'package:hexcolor/hexcolor.dart';


class exerciseNestedTabBar extends StatefulWidget {
  const exerciseNestedTabBar({super.key});
  @override
  _exerciseNestedTabBarState createState() => _exerciseNestedTabBarState();
}

class _exerciseNestedTabBarState extends State<exerciseNestedTabBar>
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
    _nestedTabController = TabController(length: 2, vsync: this);
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
          indicatorSize: TabBarIndicatorSize.tab,
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
          ],
        ),
        Container(
          height: screenHeight * 0.8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TabBarView(
            controller: _nestedTabController,
            children: const <Widget>[
              WeekExerciseTab(),
              MonthExerciseTab(),
            ],
          ),
        )
      ],
    );
  }
}
