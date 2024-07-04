import 'package:healthcare_app/src/models/char_point.dart';

class WaterPoint implements ChartPoint{
  @override
  final double x;
  @override
  late final double y;
  WaterPoint(this.x, [this.y = 0]);
}