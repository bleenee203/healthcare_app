import 'package:flutter/material.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/presentation/widgets/food_tab.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:healthcare_app/src/services/foodService.dart';
import 'package:hexcolor/hexcolor.dart';

class FoodsPage extends StatefulWidget {
  const FoodsPage({super.key});

  @override
  State<StatefulWidget> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage>
    with SingleTickerProviderStateMixin {
  // late SharedPreferences prefs;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  Offset _floatingButtonOffset = const Offset(300, 780);
  FoodService foodService = FoodService();
  late Future<List<Food>?> _foods;
  late Future<List<Food>?> _userFoods;
  @override
  void initState() {
    super.initState();
    _foods = _fetchFood();
    _userFoods = _fetchUserFood();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Food>?> _fetchFood() async {
    final foods = await foodService.fetchFood();
    print(foods);
    return foods;
  }

  Future<List<Food>?> _fetchUserFood() async {
    final foods = await foodService.fetchUserFood();
    print(foods);
    return foods;
  }

  void _searchFood(String name) async {
    if (name.isNotEmpty) {
      try {
        setState(() {
          _foods = foodService.searchFood(name);
          _userFoods = foodService.searchUserFood(name);
        });
      } catch (e) {}
    } else {
      setState(() {
        _foods = foodService.fetchFood();
        _userFoods = foodService.fetchUserFood();
      });
    }
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
                        _searchFood(value);
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TabBar(
                            tabs: const [
                              Tab(text: 'Your food'),
                              Tab(text: 'Recommend'),
                            ],
                            controller: _tabController,
                            labelStyle: const TextStyle(
                                fontFamily: 'SourceSans3', fontSize: 20),
                            labelColor: Colors.black,
                            unselectedLabelColor: HexColor("474672"),
                            indicatorColor: HexColor("474672"),
                            indicatorWeight: 3,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                FutureBuilder<List<Food>?>(
                                    future: _userFoods,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                          'Error: ${snapshot.error}',
                                          style: const TextStyle(
                                              fontFamily: 'SourceSans3',
                                              fontSize: 24),
                                        ));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: Text(
                                          'No foods available.',
                                          style: TextStyle(
                                              fontFamily: 'SourceSans3',
                                              fontSize: 24),
                                        ));
                                      } else {
                                        return FoodsTab(
                                          isUser: true,
                                          foods: snapshot.data!,
                                        );
                                      }
                                    }),
                                FutureBuilder(
                                    future: _foods,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                          'Error: ${snapshot.error}',
                                          style: const TextStyle(
                                              fontFamily: 'SourceSans3',
                                              fontSize: 24),
                                        ));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: Text(
                                          'No foods available.',
                                          style: TextStyle(
                                              fontFamily: 'SourceSans3',
                                              fontSize: 24),
                                        ));
                                      } else {
                                        return FoodsTab(
                                          isUser: false,
                                          foods: snapshot.data,
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 200,
                    // )
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
                            const Offset(300, 780); // Đặt lại vị trí ban đầu
                      });
                    }
                  },
                  child: FloatingActionButton(
                    onPressed: () {
                      RouterCustom.router
                          .pushNamed('add-food')
                          .then((_) => setState(() {}));
                    },
                    shape: const CircleBorder(),
                    backgroundColor: HexColor("BBB7EA"),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
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
