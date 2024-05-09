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
  late TabController _tabController;

  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

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
                        height: 35,
                      ),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: "Find some food...",
                            hintStyle: TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.5)),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 28,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: HexColor("FBAE9A"), width: 1)),
                            contentPadding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            )),
                        onChanged: (value) {
                          print('Search query: $value');
                        },
                      ),
                      DefaultTabController(
                        length: 2, // Số lượng tab
                        child: Expanded(
                          child: TabBarView(
                            children: [
                              // Nội dung của tab 1
                              Center(child: Text('Content for Tab 1')),
                              // Nội dung của tab 2
                              Center(child: Text('Content for Tab 2')),
                            ],
                          ),
                        ),
                      ),
                    ])))));
  }
}
