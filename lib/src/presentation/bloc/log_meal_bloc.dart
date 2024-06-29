import 'dart:async';

class LogMealBloc {
  String? _selectedOption;
  double? _kcal;
  DateTime? _date;
  final _selectedOptionController = StreamController<String?>.broadcast();
  final _kcalController = StreamController<double?>.broadcast();
  final _dateController = StreamController<DateTime?>.broadcast();
  Stream<String?> get selectedOptionStream => _selectedOptionController.stream;
  Stream<double?> get kcalStream => _kcalController.stream;
  Stream<DateTime?> get dateStream => _dateController.stream;
  void selectOption(String option) {
    _selectedOption = option;
    _selectedOptionController.sink.add(_selectedOption);
  }

  void calculateKcal(double? foodKcal) {
    _kcal = foodKcal;
    _kcalController.sink.add(_kcal);
  }

  void changeDate(DateTime? date) {
    _date = date;
    _dateController.sink.add(_date);
  }

  String? get selectedOption => _selectedOption;
  double? get kcal => _kcal;
  DateTime? get date => _date;
  void dispose() {
    _selectedOptionController.close();
    _kcalController.close();
    _dateController.close();
  }
}

var logMealBloc = LogMealBloc();
