import 'package:intl/intl.dart';

class Sleep {
  final DateTime start_time;
  final DateTime end_time;
  final int? snap_time;
  final DateTime? updated_at;
  final String? userId;
  Sleep({required this.start_time, required this.end_time, this.snap_time,
    this.updated_at, this.userId});
  // Map<String, dynamic> toJson() {
  //   return {'amount': amount};
  // }

  static DateTime _parseDate(String dateStr) {
    try {
      // First try to parse as ISO 8601
      return DateTime.parse(dateStr);
    } catch (e) {
      // If it fails, try to parse as 'dd/MM/yyyy'
      try {
        final DateFormat format = DateFormat('dd/MM/yyyy HHHH:mm:ss');
        return format.parse(dateStr);
      } catch (e) {
        print('Error parsing date: $e');
        return DateTime.now();
      }
    }
  }

// factory Exercise.fromJson(Map<String, dynamic> json) {
//   return Exercise(
//     amount: json['amount'],
//     date: _parseDate(json['date']),
//     updated_at: _parseDate(json['date']),
//   );
// }
}
