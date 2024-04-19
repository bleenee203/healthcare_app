
import 'package:flutter/material.dart';
import 'package:healthcare_app/src/presentation/pages/diagnosis_screen.dart';
import 'package:healthcare_app/src/presentation/pages/forum_screen.dart';
import 'package:healthcare_app/src/presentation/pages/home_screen.dart';
import 'package:healthcare_app/src/presentation/pages/user_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTabs extends StatefulWidget {
  const MyTabs({super.key});
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomePage(),
    const UserProfilePage(),
    const DiagnosisPage(),
    const ForumPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _tabs[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: HexColor("C48590"),
                color: HexColor("474672"),
                height: 65,
                index: _currentIndex,
                items: <Widget>[
                  _currentIndex == 0
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "res/images/home_selected.png",
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Home',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Image.asset("res/images/home.png"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Home',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                  _currentIndex == 1
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "res/images/user_selected.png",
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('User',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Image.asset("res/images/user.png"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('User',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                  _currentIndex == 2
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "res/images/heart-beat_selected.png",
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Diagnosis',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Image.asset("res/images/heart-beat.png"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Diagnosis',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                  _currentIndex == 3
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "res/images/chat_selected.png",
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Forum',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Image.asset("res/images/chat.png"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Forum',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                ],
                animationDuration: Duration(microseconds: 200000),
                onTap: _onTabTapped,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
