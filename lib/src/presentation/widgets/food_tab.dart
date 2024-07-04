import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/models/mealModel.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/foodService.dart';
import 'package:healthcare_app/src/services/mealServices.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../bloc/log_meal_bloc.dart';

class FoodsTab extends StatefulWidget {
  final bool isUser;
  final String searchQuery;
  FoodsTab({super.key, required this.isUser, required this.searchQuery});

  @override
  _FoodsTabState createState() => _FoodsTabState();
}

class _FoodsTabState extends State<FoodsTab> {
  final FoodService foodService = FoodService();
  final MealService mealService = MealService();

  List<Food>? foods;

  Future<List<Food>?> _fetchFood() async {
    if (widget.isUser) {
      if (widget.searchQuery.isNotEmpty) {
        return await foodService.searchUserFood(widget.searchQuery);
      } else {
        return await foodService.fetchUserFood();
      }
    } else {
      if (widget.searchQuery.isNotEmpty) {
        return await foodService.searchFood(widget.searchQuery);
      } else {
        return await foodService.fetchFood();
      }
    }
  }

  Future<void> _deleteFood(String? id) async {
    try {
      bool? isDeleted = await foodService.deleteFood(id);
      if (isDeleted == true) {
        Fluttertoast.showToast(
          msg: "Food item deleted successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        setState(() {});
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _addfoodofmeal(
    String? food_id,
    String? meal_type,
    String amount,
    double kcal,
    DateTime _dateValue,
  ) async {
    try {
      
      Meal data = Meal(
          meal_type: meal_type ?? '',
          food_id: food_id ?? '',
          amount: int.parse(amount),
          kcal: kcal,
          date: _dateValue,
          isDeleted: false);
      final result = await mealService.addFood(data);
      if (result == 'Add food for meal successfully') {
        Fluttertoast.showToast(
          msg: result,
          toastLength: Toast.LENGTH_SHORT, // Thời gian hiển thị
          gravity: ToastGravity.BOTTOM, // Vị trí của toast trên màn hình
          timeInSecForIosWeb: 1, // Thời gian tồn tại trên iOS/web
          backgroundColor: Colors.green, // Màu nền của toast
          textColor: Colors.white, // Màu chữ của toast
          fontSize: 16.0, // Kích thước chữ của toast
        );
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
          msg: result,
          toastLength: Toast.LENGTH_SHORT, // Thời gian hiển thị
          gravity: ToastGravity.BOTTOM, // Vị trí của toast trên màn hình
          timeInSecForIosWeb: 1, // Thời gian tồn tại trên iOS/web
          backgroundColor: Colors.red, // Màu nền của toast
          textColor: Colors.white, // Màu chữ của toast
          fontSize: 16.0, // Kích thước chữ của toast
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    //  logMealBloc = LogMealBloc();
  }

  @override
  Widget build(BuildContext context) {
    // _foodsFuture = _fetchFood();
    return FutureBuilder<List<Food>?>(
      key: UniqueKey(),
      future: _fetchFood(),
      builder: (BuildContext context, AsyncSnapshot<List<Food>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(fontFamily: 'SourceSans3', fontSize: 24),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No foods available.',
              style: TextStyle(fontFamily: 'SourceSans3', fontSize: 24),
            ),
          );
        } else {
          foods = snapshot.data;
          return SingleChildScrollView(
            child: Column(children: [
              if (foods != null)
                ...foods!.asMap().entries.map((entry) {
                  int index = entry.key;
                  Food food = entry.value;
                  return Column(
                    children: [
                      _buildFoodCard(
                          context, food.food_name, '${food.kcal} kcal', food),
                      if (index != foods!.length - 1)
                        const SizedBox(height: 18),
                    ],
                  );
                }),
              const SizedBox(height: 80),
            ]),
          );
        }
      },
    );
  }

  Widget _buildFoodCard(
      BuildContext context, String title, String subtitle, Food food) {
    return GestureDetector(
      onTap: () {
        RouterCustom.router
            .pushNamed(
          'food-detail',
          extra: food,
        )
            .then((_) async {
          List<Food>? updatedFoods = await _fetchFood();
          setState(() {
            foods = updatedFoods;
          });
        });
      },
      child: Card(
        elevation: 0,
        color: HexColor("FBAE9E").withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 14, right: 19),
          title: Text(
            title,
            style: const TextStyle(
                fontFamily: 'SourceSans3',
                fontWeight: FontWeight.w700,
                fontSize: 24),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontFamily: 'SourceSans3'),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showModalBottomSheet(context, food);
                },
                child: Image.asset('res/images/plus_food.png'),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  if (widget.isUser) {
                    await _deleteFood(food.id);
                  }
                },
                child: Image.asset('res/images/delete_food.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _dateValue = DateTime.now();

  void _showModalBottomSheet(BuildContext context, Food food) {
    TextEditingController _quantityController = TextEditingController();
    _quantityController.text = "1";
    double _calKcal = food.kcal;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: HexColor("474672").withOpacity(0.75),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
                color: HexColor("EFEFEF"),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (food.food_name),
                              style: const TextStyle(
                                  fontFamily: 'SourceSans3',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showDatePicker(context);
                              },
                              child: StreamBuilder<DateTime?>(
                                  stream: logMealBloc.dateStream,
                                  builder: (context, snapshot) {
                                    _dateValue =
                                        snapshot.data ?? DateTime.now();
                                    return Text(
                                      (DateFormat('dd/MM/yyyy')
                                          .format(_dateValue)),
                                      style: const TextStyle(
                                          fontFamily: 'SourceSans3',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        StreamBuilder<double?>(
                            stream: logMealBloc.kcalStream,
                            builder: (context, snapshot) {
                              _calKcal = snapshot.data ?? _calKcal;
                              print(_calKcal);
                              return Text(
                                '$_calKcal kcal',
                                style: const TextStyle(
                                    fontFamily: 'SourceSans3',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              );
                            }),
                        const Divider(),
                        const Text(
                          'Meal',
                          style: TextStyle(
                              fontFamily: 'SourceSans3',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildOption(context, 'Breakfast'),
                            _buildOption(context, 'Lunch'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildOption(context, 'Dinner'),
                            _buildOption(context, 'Snack'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 65),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: HexColor("D4A7C7"),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )),
                            child: IconButton(
                                onPressed: () {
                                  int currentValue =
                                      int.tryParse(_quantityController.text) ??
                                          0;
                                  if (currentValue > 1) {
                                    _quantityController.text =
                                        (currentValue - 1).toString();
                                    logMealBloc.calculateKcal(
                                        food.kcal * (currentValue - 1));
                                  }
                                },
                                icon: const Icon(Icons.remove, size: 36)),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                int quantity = int.tryParse(value) ?? 1;
                                logMealBloc.calculateKcal(food.kcal * quantity);
                              },
                              textAlign: TextAlign.center,
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: 'SourceSans3',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: HexColor("D4A7C7"),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            child: IconButton(
                              onPressed: () {
                                int currentValue =
                                    int.tryParse(_quantityController.text) ?? 0;
                                _quantityController.text =
                                    (currentValue + 1).toString();
                                print(currentValue);
                                logMealBloc.calculateKcal(
                                    food.kcal * (currentValue + 1));
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 36,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(logMealBloc.selectedOption);
                    double kcal = food.kcal *
                        (double.tryParse(_quantityController.text) ?? 0);
                    _addfoodofmeal(
                      food.id,
                      logMealBloc.selectedOption,
                      _quantityController.text,
                      kcal,
                      _dateValue,
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(HexColor("BBB7EA")),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 88),
                    child: Text(
                      'Add log',
                      style: TextStyle(
                          fontFamily: 'SourceSans3',
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOption(BuildContext context, String option) {
    return StreamBuilder<String?>(
      stream: logMealBloc.selectedOptionStream,
      builder: (context, snapshot) {
        bool isSelected = snapshot.data == option;
        return GestureDetector(
          onTap: () {
            logMealBloc.selectOption(option);
          },
          child: Container(
            width: 97,
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
                color: isSelected ? HexColor("BBB7EA") : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: isSelected
                    ? null
                    : Border.all(width: 1, color: HexColor("BBB7EA"))),
            child: Text(
              option,
              style: const TextStyle(
                fontFamily: 'SourceSans3',
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // logMealBloc.dispose();
    super.dispose();
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      logMealBloc.changeDate(picked);
    }
  }
}
