import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Exercise {
  final String? id;
  final String type;
  final double? duration;
  final double? distance;
  final double calo_burn;
  final DateTime date;
  final TimeOfDay? start_time;
  final DateTime? updated_at;
  final String? user_id;

  Exercise(
      {this.id,
      required this.type,
      this.duration,
      this.distance,
      required this.date,
      required this.calo_burn,
      this.start_time,
      this.updated_at,
      this.user_id});

  Map<String, dynamic> toJson() {
    DateTime dateTime = DateTime(date.year, date.month, date.day, start_time!.hour, start_time!.minute);

    return {
      'type': type,
      if (duration != null) 'duration': duration,
      if (distance != null) 'distance': distance,
      'date': date.toIso8601String(),
      'calo_burn': calo_burn,
      if (start_time != null)
        'start_time': dateTime.toIso8601String(),
      if (updated_at != null)
        'updated_at': DateFormat('dd/MM/yyyy').format(updated_at!),
      if (user_id != null) 'user_id': user_id,
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

  static TimeOfDay _parseTime(String timeStr) {
    DateTime dateTime = DateTime.parse(timeStr);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      duration: json['duration']?.toDouble(),
      distance: json['distance']?.toDouble(),
      calo_burn: json['calo_burn'].toDouble(),
      date: _parseDate(json['date']),
      start_time: json['start_time'] != null && json['start_time'].isNotEmpty
          ? _parseTime(json['start_time'])
          : null,
      updated_at: json['updated_at'] != null && json['updated_at'].isNotEmpty
          ? _parseDate(json['updated_at'])
          : null,
      // user_id: json['user_id'],
    );
  }
}
