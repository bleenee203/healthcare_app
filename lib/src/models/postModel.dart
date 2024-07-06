import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Post {
  final String? id;
  final String title;
  final String content;
  final String? image;
  final DateTime created_at;
  final bool isDeleted;
  final int number_cmt;
  final String? user_id;

  Post(
      {this.id,
      required this.title,
      required this.content,
      this.image,
      required this.created_at,
      required this.isDeleted,
      required this.number_cmt,
      this.user_id});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      if (image != null) 'image': image,
      'create_at': created_at.toIso8601String(),
      'isDeleted': isDeleted,
      'number_cmt': number_cmt,
      if (user_id != null) 'user_id': user_id,
    };
  }
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image'] ?? '',
      created_at: _parseDate(json['created_at']),
      isDeleted: json['isDeleted'],
      number_cmt: json['number_cmt'].toInt(),
      // user_id: json['user_id'],
    );
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

}
