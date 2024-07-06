import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/char_point.dart';

class Water3MonthChart<T extends ChartPoint> extends StatefulWidget {
  final List<Map<int, int>> months;
  const Water3MonthChart(
      {super.key, required this.points, required this.months});
  final List<T> points;

  @override
  State<Water3MonthChart<T>> createState() => _Water3MonthChartState<T>();
}

class _Water3MonthChartState<T extends ChartPoint>
    extends State<Water3MonthChart<T>> {
  // List<String> daysInMonth = [];
  // List<int> labelDays = []; // List to store the specific days to label
  // void _prepareData() {
  //   final now = DateTime.now();
  //   final int daysCount = DateTime(now.year, now.month + 1, 0).day;
  //   // labelDays.add(daysCount); // Add the last day of the month to labelDays

  //   for (int i = 1; i <= daysCount; i++) {
  //     daysInMonth.add(i.toString());
  //   }
  // }

  double _calculateMaxY(List<T> points) {
    double maxY = 0;
    for (var point in points) {
      if (point.y > maxY) {
        maxY = point.y;
      }
    }
    if (maxY != 0) {
      maxY = (maxY + 500).ceilToDouble();
      return (maxY / 500).ceil() * 500;
    }
    return 0;
  }
  
  @override
  void initState() {
    super.initState();
    // _prepareData();
    // labelDays = [
    //   widget.months[0].month,
    //   widget.months[1].month,
    //   widget.months[2].month
    // ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate the width of each bar and the spacing between them
    final barWidth = screenWidth / widget.months.length * 0.1;
    final barSpace = screenWidth / widget.months.length * 0.6;
    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: _calculateMaxY((widget.points)) == 0
              ? 2000
              : _calculateMaxY((widget.points)),
          barGroups: _chartGroups(),
          borderData: FlBorderData(border: const Border(bottom: BorderSide())),
          gridData: const FlGridData(
              show: true, horizontalInterval: 500, drawVerticalLine: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
            )),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  // return your label widget for the specific value on the y-axis
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 9),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    return widget.points
        .map(
          (point) => BarChartGroupData(
            x: point.x.toInt(),
            barRods: [
              BarChartRodData(
                toY: point.y,
                color: HexColor("474672"),
                borderRadius: BorderRadius.zero,
                // width: barWidth,
              )
            ],
            // barsSpace: barSpace,
          ),
        )
        .toList();
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (double value, TitleMeta meta) {
          int intValue = value.toInt(); // Convert double value to integer index

          // Check if the intValue matches any key positions in months
          bool shouldDisplay =
              widget.months.any((map) => map.containsKey(intValue));

          if (shouldDisplay) {
            // Return the appropriate label based on the matched key position
            String labelText = widget.months
                .firstWhere((map) => map
                    .containsKey(intValue)) // Find the map containing intValue
                .values
                .first
                .toString(); // Get the label value associated with the key

            return SideTitleWidget(
              axisSide: meta.axisSide,
              child: Text(labelText),
            );
          }

          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(''),
          );
        },
      );
}
