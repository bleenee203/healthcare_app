import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key});

  @override
  State<StatefulWidget> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
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
                                "Táo",
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
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
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
                            Text(
                              'Táo',
                              style: TextStyle(
                                  fontFamily: 'SourceSans3', fontSize: 20),
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Diertary intake',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 150,
                                ),
                                Expanded(
                                    child: TextField(
                                  keyboardType: TextInputType.number,
                                )),
                                Text(
                                  'g',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
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
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
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
                                Text(
                                  'Average nutritional \n'
                                  'value above',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.all(8),
                                      ),
                                ),
                                Text(
                                  'g',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  'Kcal',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.all(8),
                                      ),
                                ),
                                SizedBox.shrink(), // Placeholder for alignment
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  'Fat',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.all(8),
                                      ),
                                ),
                                SizedBox.shrink(), // Placeholder for alignment
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  'Carbs',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.all(8),
                                      ),
                                ),
                                SizedBox.shrink(), // Placeholder for alignment
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  'Protein',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3', fontSize: 20),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.all(8),
                                      ),
                                ),
                                SizedBox.shrink(), // Placeholder for alignment
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
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(HexColor("BBB7EA")),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 88),
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontFamily: 'SourceSans3',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
