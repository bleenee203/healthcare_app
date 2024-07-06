import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/char_point.dart';

class WaterYearChart<T extends ChartPoint> extends StatefulWidget {
  const WaterYearChart({super.key, required this.points});
  final List<T> points;

  @override
  State<WaterYearChart<T>> createState() => _WaterYearChartState<T>();
}

class _WaterYearChartState<T extends ChartPoint>
    extends State<WaterYearChart<T>> {
  // List<String> daysInMonth = [];
  List<int> labelDays = [1, 2,3,4,5,6,7,8,9,10,11,12];
  // void _prepareData() {
  //   final now = DateTime.now();
  //   final int daysCount = DateTime(now.year, now.month + 1, 0).day;
  //   labelDays.add(daysCount); // Add the last day of the month to labelDays

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
      maxY = (maxY + 100).ceilToDouble();
      return (maxY / 100).ceil() * 100;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    // _prepareData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate the width of each bar and the spacing between them
    final barWidth = screenWidth / labelDays.length * 0.6;
    final barSpace = screenWidth / labelDays.length * 0.4;
    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: _calculateMaxY((widget.points)) == 0
              ? 2000
              : _calculateMaxY((widget.points)),
          barGroups: _chartGroups(barWidth, barSpace),
          borderData: FlBorderData(border: const Border(bottom: BorderSide())),
          gridData: const FlGridData(
              show: true, horizontalInterval: 200, drawVerticalLine: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
            )),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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

  List<BarChartGroupData> _chartGroups(barWidth, barSpace) {
    return widget.points
        .map(
          (point) => BarChartGroupData(
            x: point.x.toInt(),
            barRods: [
              BarChartRodData(
                toY: point.y,
                color: HexColor("474672"),
                borderRadius: BorderRadius.zero,
                width: barWidth,
              )
            ],
            barsSpace: barSpace,
          ),
        )
        .toList();
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (double value, TitleMeta meta) {
          int intValue =
              value.toInt() + 1; // Convert zero-based index to day number
          if (labelDays.contains(intValue)) {
            return SideTitleWidget(
              axisSide: meta.axisSide,
              child: Text(intValue.toString()),
            );
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(''),
          );
        },
      );
}

//Bar char của Sleep
