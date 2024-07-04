import 'package:intl/intl.dart';

class User {
  final String? fullname;
  final bool? gender;
  final String? phone;
  final DateTime? birthday;
  final String? career;
  final String? cccd;
  final String? blood_type;
  final double? calo_target;
  final int? water_target;

  User(
      {this.fullname,
      this.gender,
      this.phone,
      this.birthday,
      this.career,
      this.cccd,
      this.blood_type,
      this.calo_target,
      this.water_target});
  Map<String, dynamic> toJson() {
    return {
      if (fullname != null) 'fullname': fullname,
      if (gender != null) 'gender': gender,
      if (phone != null) 'phone': phone,
      if (career != null) 'career': career,
      if (cccd != null) 'cccd': cccd,
      if (birthday != null)
        'birthday': DateFormat('dd/MM/yyyy').format(birthday!),
      if (blood_type != null) 'blood_type': blood_type,
      if (calo_target != null) 'calo_target': calo_target,
      if (water_target != null) 'water_target': water_target,
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
        blood_type: json['blood_type'] ?? '',
        calo_target: json['calo_target']?.toDouble(),
        water_target: json['water_target']?.toInt());
  }
}
