import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/foodService.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFoodPage extends StatefulWidget {
  final Food? food;
  const AddFoodPage({super.key, this.food});

  @override
  State<StatefulWidget> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _rationController = TextEditingController();
  final _nutritionalValueController = TextEditingController();
  final _kcalController = TextEditingController();
  final _fatController = TextEditingController();
  final _carbsController = TextEditingController();
  final _proteinController = TextEditingController();
  FoodService foodService = FoodService();
  Future<void> _updateFood(String id, newData) async {
    try {
      final result = await foodService.updateFood(id, newData);
      if (result?['success'].toString() == 'true') {
        Fluttertoast.showToast(
          msg: result?['message'],
          toastLength: Toast.LENGTH_SHORT, // Thời gian hiển thị
          gravity: ToastGravity.BOTTOM, // Vị trí của toast trên màn hình
          timeInSecForIosWeb: 1, // Thời gian tồn tại trên iOS/web
          backgroundColor: Colors.green, // Màu nền của toast
          textColor: Colors.white, // Màu chữ của toast
          fontSize: 16.0, // Kích thước chữ của toast
        );
        Navigator.of(context).pop(result?['data']);
      } else if (result?['success'].toString() == 'false') {
        Fluttertoast.showToast(
          msg: result?['message'],
          toastLength: Toast.LENGTH_SHORT, // Thời gian hiển thị
          gravity: ToastGravity.BOTTOM, // Vị trí của toast trên màn hình
          timeInSecForIosWeb: 1, // Thời gian tồn tại trên iOS/web
          backgroundColor: Colors.red, // Màu nền của toast
          textColor: Colors.white, // Màu chữ của toast
          fontSize: 16.0, // Kích thước chữ của toast
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT, // Thời gian hiển thị
        gravity: ToastGravity.BOTTOM, // Vị trí của toast trên màn hình
        timeInSecForIosWeb: 1, // Thời gian tồn tại trên iOS/web
        backgroundColor: Colors.red, // Màu nền của toast
        textColor: Colors.white, // Màu chữ của toast
        fontSize: 16.0, // Kích thước chữ của toast
      );
      print(error);
    }
  }

  Future<void> _addFood(newData) async {
    try {
      final result = await foodService.addFood(newData);
      if (result == 'Food created successfully') {
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
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT, // Thời gian hiển thị
        gravity: ToastGravity.BOTTOM, // Vị trí của toast trên màn hình
        timeInSecForIosWeb: 1, // Thời gian tồn tại trên iOS/web
        backgroundColor: Colors.red, // Màu nền của toast
        textColor: Colors.white, // Màu chữ của toast
        fontSize: 16.0, // Kích thước chữ của toast
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _foodNameController.text = widget.food?.food_name ?? '';
    _rationController.text = widget.food?.ration.toString() ?? '0';
    _nutritionalValueController.text = widget.food?.avg_above.toString() ?? '0';
    _kcalController.text = widget.food?.kcal.toString() ?? '0';
    _carbsController.text = widget.food?.carbs.toString() ?? '0';
    _proteinController.text = widget.food?.protein.toString() ?? '0';
    _fatController.text = widget.food?.fat.toString() ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
                height: double.infinity,
                color: const Color(0xfffbedec),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    if (RouterCustom.router.canPop()) {
                                      RouterCustom.router.pop();
                                    }
                                  },
                                  child: Image.asset('res/images/go-back.png'),
                                ),
                              ),
                              Center(
                                child: Text(
                                  widget.food?.food_name ?? "Add food",
                                  style: TextStyle(
                                    color: HexColor("474672"),
                                    fontFamily: "SourceSans3",
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              // Image.asset("res/images/noti.png"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        const Text(
                          'Basic Information',
                          style: TextStyle(
                              fontFamily: 'SourceSans3',
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Name of food',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _foodNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the name of the food!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.2),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Ration',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    controller: _rationController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the ration!';
                                      }
                                      return null;
                                    },
                                  )),
                                  const Text(
                                    'g',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: FlexColumnWidth(),
                              2: IntrinsicColumnWidth(),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.bottom,
                            children: [
                              TableRow(
                                children: [
                                  const Text(
                                    'Average nutritional \n'
                                    'value above',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  TextFormField(
                                    controller: _nutritionalValueController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the average nutritional value!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        // contentPadding: EdgeInsets.all(8),
                                        ),
                                  ),
                                  const Text(
                                    'g',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    'Kcal',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  TextFormField(
                                    controller: _kcalController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter kcal!';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        // contentPadding: EdgeInsets.all(8),
                                        ),
                                  ),
                                  const SizedBox
                                      .shrink(), // Placeholder for alignment
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    'Fat',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  TextField(
                                    controller: _fatController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        // contentPadding: EdgeInsets.all(8),
                                        ),
                                  ),
                                  const SizedBox
                                      .shrink(), // Placeholder for alignment
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    'Carbs',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  TextField(
                                    controller: _carbsController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        // contentPadding: EdgeInsets.all(8),
                                        ),
                                  ),
                                  const SizedBox
                                      .shrink(), // Placeholder for alignment
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text(
                                    'Protein',
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  TextField(
                                    controller: _proteinController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        // contentPadding: EdgeInsets.all(8),
                                        ),
                                  ),
                                  const SizedBox
                                      .shrink(), // Placeholder for alignment
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 200,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                Food data = Food(
                                    food_name: _foodNameController.text,
                                    ration:
                                        double.parse(_rationController.text),
                                    avg_above: double.parse(
                                        _nutritionalValueController.text),
                                    kcal: double.parse(_kcalController.text),
                                    fat: double.tryParse(_fatController.text),
                                    carbs:
                                        double.tryParse(_carbsController.text),
                                    protein: double.tryParse(
                                        _proteinController.text),
                                    isDeleted: false);
                                widget.food != null
                                    ? _updateFood(widget.food?.id ?? '', data)
                                    : _addFood(data);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    HexColor("BBB7EA")),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 88),
                              child: Text(
                                widget.food != null ? 'Update' : 'Add food',
                                style: const TextStyle(
                                    fontFamily: 'SourceSans3',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
