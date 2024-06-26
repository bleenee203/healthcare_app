import 'package:intl/intl.dart';

class User {
  final String? fullname;
  final bool? gender;
  final String? phone;
  final DateTime? birthday;
  final String? career;
  final String? cccd;
  final String? blood_type;

  User(
      {this.fullname,
      this.gender,
      this.phone,
      this.birthday,
      this.career,
      this.cccd,
      this.blood_type});
  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'gender': gender,
      'phone': phone,
      'career': career,
      'cccd': cccd,
      'birthday': birthday?.toIso8601String(),
      'blood_type': blood_type
    };
  }
  static DateTime? _parseDate(String dateStr) {
    try {
      // First try to parse as ISO 8601
      return DateTime.parse(dateStr);
    } catch (e) {
      // If it fails, try to parse as 'dd/MM/yyyy'
      try {
        final DateFormat format = DateFormat('dd/MM/yyyy');
        return format.parse(dateStr);
      } catch (e) {
        print('Error parsing date: $e');
        return null;
      }
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    bool? parsedGender;

  if (json.containsKey('gender')) {
    final dynamic genderValue = json['gender'];

    if (genderValue is bool) {
      parsedGender = genderValue;
    } else if (genderValue is String) {
      parsedGender = genderValue.toLowerCase() == 'true';
    } else {
      parsedGender = null;
    }
  }
    return User(
        phone: json['phone'] ?? '',
        fullname: json['fullname'] ?? '',
        gender: parsedGender,
        career: json['career'] ?? '',
        birthday: json['birthday'] != null && json['birthday'].isNotEmpty
            ? _parseDate(json['birthday'])
            : null,
        cccd: json['cccd'] ?? '',
        blood_type: json['blood_type'] ?? '');
  }
}
