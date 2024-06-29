import 'package:intl/intl.dart';

class Meal {
  final String? id;
  final String meal_type;
  final DateTime date;
  final int amount;
  final double kcal;
  final bool isDeleted;
  final String food_id;
  // final String? user_id;
  Meal(
      {this.id,
      required this.meal_type,
      required this.date,
      required this.amount,
      required this.kcal,
      required this.isDeleted,
      required this.food_id,
      // this.user_id
      });
  Map<String, dynamic> toJson() {
    return {
      'meal_type': meal_type,
      'date': DateFormat('dd/MM/yyyy').format(date),
      'amount': amount,
      'kcal': kcal,
      'isDeleted': isDeleted,
      'food_id': food_id,
      // 'user_id': user_id
    };
  }

  static DateTime _parseDate(String dateStr) {
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
        return DateTime.now();
      }
    }
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
        id: json['id'],
        meal_type: json['meal_type'],
        date: _parseDate(json['date']),
        amount: (json['amount']).toInt(),
        kcal: (json['kcal']).toDouble(),
        isDeleted: json['isDeleted'],
        food_id: json['food_id'],
        // user_id: json['user_id']
        );
  }
}
