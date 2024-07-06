import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarChartSample extends StatefulWidget {
  @override
  _BarChartSampleState createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  List<double> barValues = [];
  List<String> daysInMonth = [];
  List<int> labelDays = [1, 10, 20]; // List to store the specific days to label

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  void _prepareData() {
    final now = DateTime.now();
    final int daysCount = DateTime(now.year, now.month + 1, 0).day;
    labelDays.add(daysCount); // Add the last day of the month to labelDays

    for (int i = 1; i <= daysCount; i++) {
      daysInMonth.add(i.toString());
      // Add your data here, using random values for demonstration
      barValues.add((i % 15 + 5).toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate the width of each bar and the spacing between them
    final barWidth = screenWidth / daysInMonth.length * 0.6;
    final barSpace = screenWidth / daysInMonth.length * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bar Chart Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: barValues.asMap().entries.map((entry) {
                int index = entry.key;
                double value = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value,
                      color: Colors.blue,
                      width: barWidth,
                    ),
                  ],
                  barsSpace: barSpace,
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      int intValue = value.toInt() +
                          1; // Convert zero-based index to day number
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
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(enabled: false),
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: BarChartSample()));
