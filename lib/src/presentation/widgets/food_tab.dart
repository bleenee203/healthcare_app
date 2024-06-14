import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../bloc/log_meal_bloc.dart';

class FoodsTab extends StatefulWidget {
  const FoodsTab({super.key});

  @override
  _FoodsTabState createState() => _FoodsTabState();
}

class _FoodsTabState extends State<FoodsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFoodCard(context, 'Táo', '120g - 95 calo'),
          const SizedBox(height: 18),
          _buildFoodCard(context, 'Táo', '120g - 95 calo'),
        ],
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, String title, String subtitle) {
    return Card(
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
                _showModalBottomSheet(context);
              },
              child: Image.asset('res/images/plus_food.png'),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {},
              child: Image.asset('res/images/delete_food.png'),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: HexColor("474672").withOpacity(0.75),
      builder: (BuildContext context) {
        return Container(
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

  @override
  void dispose() {
    logMealBloc.dispose(); // Dispose the FoodsBloc when the widget is disposed
    super.dispose();
  }
}