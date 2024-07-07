import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Comment {
  final String? id;
  final String post_id;
  final String content;
  final String? comment_id;
  final DateTime created_at;
  final bool isDeleted;
  final String? user_id;

  Comment(
      {this.id,
        required this.post_id,
        required this.content,
        this.comment_id,
        required this.created_at,
        required this.isDeleted,
        this.user_id});

  Map<String, dynamic> toJson() {
    return {
      'post_id': post_id,
      'content': content,
      if (comment_id != null) 'comment_id': comment_id,
      'create_at': created_at.toIso8601String(),
      'isDeleted': isDeleted,
      if (user_id != null) 'user_id': user_id,
    };
  }
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      post_id: json['post_id'] ?? '',
      content: json['content'] ?? '',
      comment_id: json['comment_id'] ?? '',
      created_at: _parseDate(json['created_at']),
      isDeleted: json['isDeleted'],
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
