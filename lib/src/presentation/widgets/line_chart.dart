import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/char_point.dart';

class LineChartWidget<T extends ChartPoint> extends StatefulWidget {
  const LineChartWidget({super.key, required this.points});

  final List<T> points;

  @override
  State<LineChartWidget<T>> createState() =>
      _LineChartWidgetState<T>(points: this.points);
}

class _LineChartWidgetState<T extends ChartPoint> extends State<LineChartWidget<T>> {
  final List<T> points;

  _LineChartWidgetState({required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: true,
                color: HexColor("474672"),
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: HexColor("474672").withOpacity(0.3),
                ),
              ),
            ],
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
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

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(text),
                    );
                  },
                  reservedSize: 30,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String text;
                    switch (value.toInt()) {
                      case 22:
                        text = '22:00';
                        break;
                      case 0:
                        text = '00:00';
                        break;
                      case 2:
                        text = '02:00';
                        break;
                      default:
                        return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(text),
                    );
                  },
                  reservedSize: 40,
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
                right: BorderSide.none,
                top: BorderSide.none,
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              drawHorizontalLine: true,
              verticalInterval: 1,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 0.5,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 0.5,
                );
              },
            ),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor:(data) => Colors.blueGrey,
              ),
              handleBuiltInTouches: true,
            ),
          ),
        ),
      ),
    );
  }
}
