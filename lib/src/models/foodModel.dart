class Food {
  final String food_name;
  final double kcal;
  final double? carbs;
  final double? protein;
  final double? fat;
  final bool isDeleted;
  final double ration;
  final double avg_above;
  final String? user_id;
  Food(
      {required this.food_name,
      required this.kcal,
      this.carbs,
      this.protein,
      this.fat,
      required this.avg_above,
      required this.ration,
      required this.isDeleted,
      this.user_id});
  Map<String, dynamic> toJson() {
    return {
      'food_name': food_name,
      'kcal': kcal,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'ration': ration,
      'avg_above': avg_above,
      'isDeleted': isDeleted,
      'user_id': user_id
    };
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        food_name: json['food_name'],
        kcal: (json['kcal']).toDouble(),
        carbs: (json['carbs'] ?? 0).toDouble(),
        protein: (json['protein'] ?? 0).toDouble(),
        fat: (json['fat'] ?? 0).toDouble(),
        ration: json['ration'].toDouble(),
        avg_above: (json['avg_above']).toDouble(),
        isDeleted: json['isDeleted'],
        user_id: json['blood_type']);
  }
}
