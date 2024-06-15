class User {
  final String? fullname;
  final String? gender;
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        phone: json['phone'] ?? '',
        fullname: json['fullname'] ?? '',
        gender: json['gender'] ?? '',
        career: json['career'] ?? '',
        birthday: json['birthday'] != null
            ? DateTime.parse(json['birthday'])
            : null, // Parse birthday if not null
        cccd: json['cccd'] ?? '',
        blood_type: json['blood_type'] ?? '');
  }
}
