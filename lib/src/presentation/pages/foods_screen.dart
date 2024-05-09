import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MaterialApp(home: FoodsPage()));
}

class FoodsPage extends StatefulWidget {
  const FoodsPage({super.key});

  @override
  State<StatefulWidget> createState() => _FoodsPage();
}

class _FoodsPage extends State<FoodsPage> {
  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
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
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 35),
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
                            Text(
                              "NUTRITION",
                              style: TextStyle(
                                color: HexColor("474672"),
                                fontFamily: "SourceSans3",
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Image.asset("res/images/noti.png"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 38,
                      ),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Find some food...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: HexColor("FBAE9E"))),
                        ),
                        onChanged: (value) {
                          print('Search query: $value');
                        },
                      )
                    ])))));
  }
}
