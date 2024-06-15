import 'dart:async';

class LogMealBloc {
  String? _selectedOption;
  final _selectedOptionController = StreamController<String?>.broadcast();

  Stream<String?> get selectedOptionStream => _selectedOptionController.stream;

  void selectOption(String option) {
    _selectedOption = option;
    _selectedOptionController.sink.add(_selectedOption);
  }

  String? get selectedOption => _selectedOption;

  void dispose() {
    _selectedOptionController.close();
  }
}

final logMealBloc = LogMealBloc();
