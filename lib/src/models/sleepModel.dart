import 'package:intl/intl.dart';

class Sleep {
  final DateTime start_time;
  final DateTime end_time;
  final int duration;
  final DateTime? updated_at;
  final String? user_id;

  Sleep(
      {required this.start_time,
      required this.end_time,
        required this.duration,
      this.updated_at,
      this.user_id});

  Map<String, dynamic> toJson() {
    return {
      'start_time': start_time.toIso8601String(),
      'end_time': end_time.toIso8601String(),
      'duration': duration
    };
  }

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

factory Sleep.fromJson(Map<String, dynamic> json) {
  return Sleep(
    start_time: _parseDate(json['start_time']),
    end_time: _parseDate(json['end_time']),
    duration: json['duration'].toInt(),
    updated_at: _parseDate(json['updated_at']),
    user_id: json['user_id']
  );
}
}
