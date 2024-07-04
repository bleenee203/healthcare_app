import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/presentation/bloc/log_meal_bloc.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class FoodDetailPage extends StatefulWidget {
  Food food;
  FoodDetailPage({super.key, required this.food});

  @override
  State<StatefulWidget> createState() => _FoodDetailPage();
}

class _FoodDetailPage extends State<FoodDetailPage> {
  Food? food;
  final TextEditingController _quantityController = TextEditingController();
  final List<String> nutritions = ['Carbs', 'Protein', 'Fat'];
  late List<PieChartSectionData> sections;
  List<PieChartSectionData> _buildPieChartSections() {
    final carbs = food?.carbs ?? 0;
    final protein = food?.protein ?? 0;
    final fat = food?.fat ?? 0;
    final total = carbs + protein + fat;
    // Avoid division by zero
    if (total == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 100,
          radius: 50,
          title: '0%',
          titleStyle: const TextStyle(fontFamily: 'SourceSans3', fontSize: 14),
        )
      ];
    }

    return [
      PieChartSectionData(
        color: HexColor("FBAE9E"),
        value: carbs / total * 100,
        radius: 50,
        title: '${(carbs / total * 100).toStringAsFixed(1)}%',
        titleStyle: const TextStyle(fontFamily: 'SourceSans3', fontSize: 14),
      ),
      PieChartSectionData(
        color: HexColor("F06244"),
        value: protein / total * 100,
        radius: 50,
        title: '${(protein / total * 100).toStringAsFixed(1)}%',
        titleStyle: const TextStyle(fontFamily: 'SourceSans3', fontSize: 14),
      ),
      PieChartSectionData(
        color: HexColor("BBB7EA"),
        value: fat / total * 100,
        radius: 50,
        title: '${(fat / total * 100).toStringAsFixed(1)}%',
        titleStyle: const TextStyle(fontFamily: 'SourceSans3', fontSize: 14),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    food = widget.food;
    sections = _buildPieChartSections();
    print(sections.length);
    _quantityController.text = widget.food.avg_above.toString();
  }

  @override
  void dispose() {
    super.dispose();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (RouterCustom.router.canPop()) {
                              RouterCustom.router.pop();
                            }
                          },
                          child: Image.asset('res/images/go-back.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              key: UniqueKey(),
                              food?.food_name ?? '',
                              style: TextStyle(
                                color: HexColor("474672"),
                                fontFamily: "SourceSans3",
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              RouterCustom.router
                                  .pushNamed('update-food', extra: food)
                                  .then((value) => setState(() {
                                        if (value != null) {
                                          Map<String, dynamic> foodData =
                                              value as Map<String, dynamic>;
                                          food = Food.fromJson(foodData);
                                          sections = _buildPieChartSections();
                                        }
                                      }));
                            },
                            child: Image.asset("res/images/edit.png")),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const Text(
                    'Nutritional components',
                    style: TextStyle(
                        fontFamily: 'SourceSans3',
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 77,
                        height: 42,
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
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _quantityController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 11)),
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'SourceSans3'),
                        ),
                      ),
                      const SizedBox(
                        width: 17,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            height: 42,
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
                            child: const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Text(
                                'gram',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'SourceSans3'),
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(children: [
                          PieChart(PieChartData(
                            sections: sections,
                            centerSpaceRadius: 60,
                          )),
                          Center(
                            child: Text(
                              (food?.kcal.toString() ?? '0') + ' kcal',
                              style: const TextStyle(
                                  fontFamily: 'SourceSans3',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ]),
                      ),
                      const SizedBox(
                        width: 65,
                      ),
                      Column(
                          children: nutritions.map((e) {
                        String nutritionValue = '';
                        switch (e) {
                          case 'Carbs':
                            nutritionValue = '${food?.carbs}g';
                            break;
                          case 'Protein':
                            nutritionValue = '${food?.protein}g';
                            break;
                          case 'Fat':
                            nutritionValue = '${food?.fat}g';
                            break;
                          default:
                            nutritionValue = '';
                            break;
                        }
                        return SizedBox(
                          width: MediaQuery.of(context).size.width - 305,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  leading: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: sections.length >
                                                nutritions.indexOf(e)
                                            ? sections[nutritions.indexOf(e)]
                                                .color
                                            : Colors.grey,
                                        shape: BoxShape.circle),
                                  ),
                                  title: Text(
                                    '${e}',
                                    style: const TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    nutritionValue,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontFamily: 'SourceSans3',
                                        fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList())
                    ],
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          _showModalBottomSheet(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("BBB7EA")),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 88),
                          child: Text(
                            'Add log',
                            style: TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
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
                        const Text(
                          'Táo',
                          style: TextStyle(
                              fontFamily: 'SourceSans3',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        const Text(
                          '95 calo',
                          style: TextStyle(
                              fontFamily: 'SourceSans3',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
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
                            child: const Icon(
                              Icons.remove,
                              size: 36,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          const Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'SourceSans3',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: HexColor("D4A7C7"),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            child: const Icon(
                              Icons.add,
                              size: 36,
                            ),
                          ),
                        ],
                      )),
                ),
                ElevatedButton(
                  onPressed: () {},
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
            logMealBloc
                .selectOption(option); // Update selected option in FoodsBloc
            // Navigator.pop(context); // Close the bottom sheet
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
}
