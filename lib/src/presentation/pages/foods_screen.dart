import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/presentation/widgets/food_tab.dart';
import 'package:intl/intl.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class FoodsPage extends StatefulWidget {
  const FoodsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  Offset _floatingButtonOffset =
      Offset(300, 780); // Vị trí ban đầu của FloatingActionButton

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
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
                          color: Colors.black.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 28,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: HexColor("FBAE9A"), width: 1),
                        ),
                        contentPadding: const EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                        ),
                      ),
                      onChanged: (value) {
                        print('Search query: $value');
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TabBar(
                            tabs: [
                              Tab(text: 'Your food'),
                              Tab(text: 'Recommend'),
                            ],
                            controller: _tabController,
                            labelStyle: TextStyle(
                                fontFamily: 'SourceSans3', fontSize: 20),
                            labelColor: Colors.black,
                            unselectedLabelColor: HexColor("474672"),
                            indicatorColor: HexColor("474672"),
                            indicatorWeight: 3,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                FoodsTab(),
                                FoodsTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: _floatingButtonOffset.dx,
                top: _floatingButtonOffset.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _floatingButtonOffset += details.delta;
                    });
                  },
                  onPanEnd: (details) {
                    // Kiểm tra vị trí của nút sau khi kết thúc di chuyển
                    final size = MediaQuery.of(context).size;
                    if (_floatingButtonOffset.dx < 0 ||
                        _floatingButtonOffset.dx > size.width ||
                        _floatingButtonOffset.dy < 0 ||
                        _floatingButtonOffset.dy > size.height) {
                      // Nếu nút di chuyển ra ngoài kích thước màn hình thì ẩn nút đi
                      setState(() {
                        _floatingButtonOffset =
                            Offset(0, 0); // Đặt lại vị trí ban đầu
                      });
                    }
                  },
                  child: FloatingActionButton(
                    onPressed: () {},
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                    backgroundColor: HexColor("BBB7EA"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
