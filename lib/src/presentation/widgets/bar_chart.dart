import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/char_point.dart';

class BarChartWidget<T extends ChartPoint> extends StatefulWidget {
  const BarChartWidget({super.key, required this.points});

  final List<T> points;

  @override
  State<BarChartWidget<T>> createState() =>
      _BarChartWidgetState<T>(points: this.points);
}

class _BarChartWidgetState<T extends ChartPoint> extends State<BarChartWidget<T>> {
  final List<T> points;

  _BarChartWidgetState({required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        BarChartData(
          barGroups: _chartGroups(),
          borderData: FlBorderData(border: const Border(bottom: BorderSide())),
          gridData: const FlGridData(
              show: true, horizontalInterval: 1000, drawVerticalLine: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(
              showTitles: false,
            )),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
            )),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    return points
        .map(
          (point) => BarChartGroupData(x: point.x.toInt(), barRods: [
            BarChartRodData(
                toY: point.y,
                color: HexColor("474672"),
                borderRadius: BorderRadius.zero)
          ]),
        )
        .toList();
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'M';
              break;
            case 1:
              text = 'T';
              break;
            case 2:
              text = 'W';
              break;
            case 3:
              text = 'T';
              break;
            case 4:
              text = 'F';
              break;
            case 5:
              text = 'S';
              break;
            case 6:
              text = 'S';
              break;
          }

          return Text(text);
        },
      );
}

//Bar char của Sleep
