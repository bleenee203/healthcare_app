import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/char_point.dart';

class WeekExerciseChartWidget extends StatefulWidget {
  const WeekExerciseChartWidget(
      {super.key,
        this.sunday = false,
        this.monday = false,
        this.tuesday = false,
        this.wednesday = false,
        this.thursday = false,
        this.friday = false,
        this.saturday = false});

  final bool sunday;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;

  @override
  State<WeekExerciseChartWidget> createState() => _WeekExerciseChartWidgetState();
}

class _WeekExerciseChartWidgetState<T extends ChartPoint>
    extends State<WeekExerciseChartWidget> {
  _WeekExerciseChartWidgetState();

  Widget _buildContainer(bool check, String dayname) {
    return Column(
      children: [
        Container(
          width: 27,
          height: 55,
          decoration: BoxDecoration(
            color: check
                ? HexColor("908BD5")
                : HexColor("BBB7EA"), // Đổi màu khi check
            borderRadius: BorderRadius.circular(20),
          ),
          child: check
              ? const Icon(Icons.check_rounded,
              color: Colors.white, size: 16) // Thêm icon khi check
              : null,
        ),
        Text(
          dayname,
          style: TextStyle(
              fontFamily: "SourceSans3",
              fontSize: 16,
              color: Colors.black.withOpacity(0.5)),
        ),
      ],
    );
  }

  int _getExerciseDaysCount() {
    return [
      widget.sunday,
      widget.monday,
      widget.tuesday,
      widget.wednesday,
      widget.thursday,
      widget.friday,
      widget.saturday,
    ].where((day) => day == true).length;
  }

  @override
  Widget build(BuildContext context) {
    int exerciseDaysCount = _getExerciseDaysCount();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: "$exerciseDaysCount ",
                style: const TextStyle(
                  fontFamily: "SourceSans3",
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              const TextSpan(
                text: " of ",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const TextSpan(
                text: " 7 ",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              const TextSpan(
                text: "exercise days",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildContainer(widget.monday, "M"),
            const SizedBox(
              width: 30,
            ),
            _buildContainer(widget.tuesday, "T"),
            const SizedBox(
              width: 30,
            ),
            _buildContainer(widget.wednesday, "W"),
            const SizedBox(
              width: 30,
            ),
            _buildContainer(widget.thursday, "T"),
            const SizedBox(
              width: 30,
            ),
            _buildContainer(widget.friday, "F"),
            const SizedBox(
              width: 30,
            ),
            _buildContainer(widget.saturday, "S"),
            const SizedBox(
              width: 30,
            ),
            _buildContainer(widget.sunday, "S"),
          ],
        ),
      ],
    );
  }
}
