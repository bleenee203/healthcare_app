import 'package:healthcare_app/src/models/char_point.dart';

class SleepPoint implements ChartPoint{
  @override
  final double x; // Giá trị trục x
  @override
  late final double y; // Giá trị trục y
  SleepPoint(this.x, [this.y = 0]); // Sử dụng giá trị mặc định cho tham số y nếu không được cung cấp
}