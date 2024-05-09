import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/water_point.dart';
import 'package:healthcare_app/src/presentation/widgets/bar_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class WeekWaterTab extends StatefulWidget {
  const WeekWaterTab({super.key});
  @override
  State<WeekWaterTab> createState() => _WeekWaterTab();
}

class _WeekWaterTab extends State<WeekWaterTab> {
  late DateTime _datevalue;
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
    _datevalue = DateTime.now();
  }

  @override
  void dispose() {  
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => _moveToPreviousWeek(context),
                  child: Image.asset("res/images/left.png")),
              Text(
                getWeekRangeString(_datevalue),
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: _datevalue.day == DateTime.now().day
                    ? null
                    : () => _moveToNextWeek(context),
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
          const Align(
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
                  const Text(
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
                  const Text(
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
                  const Text(
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
          const Align(
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
              const Text(
                "1000",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "ml of your ",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                ),
              ),
              const Text(
                "2000",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "ml goal",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 16,
                ),
              ),
              Image.asset("res/images/target.png")
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Th5",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
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
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Th4",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 60,
              ),
              const Expanded(
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
          const Divider(
            thickness: 1,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Th3",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
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
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Th2",
                style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 60,
              ),
              const Expanded(
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
    );
    
  }
  void _moveToPreviousWeek(BuildContext context) {
    DateTime lastweek = _datevalue.subtract(Duration(days: 7));
    setState(() {
      _datevalue = lastweek;
    });
  }

  void _moveToNextWeek(BuildContext context) {
    DateTime nextweek = _datevalue.add(Duration(days: 7));
    setState(() {
      _datevalue = nextweek;
    });
  }
  String getWeekRangeString(DateTime date) {
    // Lấy ngày đầu tiên của tuần (Chủ nhật)
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Lấy ngày cuối cùng của tuần (Thứ bảy)
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

    // Biến đổi ngày thành chuỗi
    String firstDayString = DateFormat('MMMM d').format(firstDayOfWeek);
    String lastDayString = DateFormat('MMMM d').format(lastDayOfWeek);

    return '$firstDayString - $lastDayString';
  }
}
