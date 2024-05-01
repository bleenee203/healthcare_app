import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthcare_app/src/presentation/widgets/ImageSliderWithDots.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey _targetWidgetKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView(controller: _scrollController, children: <Widget>[
      Container(
        color: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xfffbedec),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 273.923,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                    decoration: const BoxDecoration(color: Color(0xFFF5E2D0)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 192,
                          width: 267.178,
                          top: 104,
                          height: 231.414,
                          child: Image.asset(
                            'res/images/image1_3199.png',
                            width: 267.178,
                            height: 231.414,
                          ),
                        ),
                        Positioned(
                          left: -89,
                          width: 284.106,
                          top: -91,
                          height: 273.923,
                          child: Image.asset(
                            'res/images/image2_3200.png',
                            width: 284.106,
                            height: 273.923,
                          ),
                        ),
                        Positioned(
                          left: 25,
                          width: 66.403,
                          top: 54,
                          height: 57.186,
                          child: Image.asset(
                            'res/images/image3_3346.png',
                            width: 66.403,
                            height: 57.186,
                          ),
                        ),
                        Positioned(
                          left: 301.486,
                          width: 63.514,
                          top: 194,
                          height: 50.565,
                          child: Image.asset(
                            'res/images/image4_3347.png',
                            width: 63.514,
                            height: 50.565,
                          ),
                        ),
                        Positioned(
                          left: 356,
                          width: 12.13,
                          top: 177,
                          height: 12.13,
                          child: Image.asset(
                            'res/images/image5_3348.png',
                            width: 12.13,
                            height: 12.13,
                          ),
                        ),
                        Positioned(
                          left: 168,
                          width: 191,
                          top: 205,
                          height: 28,
                          child: Image.asset(
                            'res/images/image6_3349.png',
                            width: 191,
                            height: 28,
                          ),
                        ),
                        const Positioned(
                          left: 25,
                          top: 176,
                          child: Text(
                            'Take your care',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 12,
                                color: Color(0xffcd2222),
                                fontFamily: 'SourceSans3',
                                fontWeight: FontWeight.w900),
                            // maxLines: 9999,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Positioned(
                          left: 25,
                          top: 196,
                          child: Text(
                            'Save your life',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 11,
                                color: Color(0xff000000),
                                fontFamily: 'SourceSans3',
                                fontWeight: FontWeight.w900),
                            // maxLines: 9999,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Positioned(
                          left: 106,
                          right: 0,
                          top: 94,
                          bottom: 0,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 3,
                                child: Transform.rotate(
                                  angle: -0.25,
                                  child: const Text(
                                    'E',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 40,
                                        color: Color(0xff263948),
                                        fontFamily: 'AlfaSlabOne',
                                        fontWeight: FontWeight.normal),
                                    //overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 33,
                                top: 2,
                                child: Transform.rotate(
                                  angle: 0.14,
                                  child: const Text(
                                    'N',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 40,
                                        color: Color(0xff263948),
                                        fontFamily: 'AlfaSlabOne',
                                        fontWeight: FontWeight.normal),
                                    //maxLines: 9999,
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 70,
                                top: 5,
                                child: Transform.rotate(
                                  angle: -0.25,
                                  child: const Text(
                                    'E',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 40,
                                        color: Color(0xff263948),
                                        fontFamily: 'AlfaSlabOne',
                                        fontWeight: FontWeight.normal),
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 97,
                                top: 0,
                                child: Transform.rotate(
                                  angle: 0.5,
                                  child: const Text(
                                    'R',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 40,
                                        color: Color(0xff263948),
                                        fontFamily: 'AlfaSlabOne',
                                        fontWeight: FontWeight.normal),
                                    // maxLines: 9999,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 125,
                                top: 3,
                                child: Transform.rotate(
                                  angle: -0.26,
                                  child: const Text(
                                    'G',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 40,
                                        color: Color(0xff263948),
                                        fontFamily: 'AlfaSlabOne',
                                        fontWeight: FontWeight.normal),
                                    // maxLines: 9999,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 151,
                                top: 2,
                                child: Transform.rotate(
                                  angle: 0.14,
                                  child: const Text(
                                    'Y',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 40,
                                        color: Color(0xff263948),
                                        fontFamily: 'AlfaSlabOne',
                                        fontWeight: FontWeight.normal),
                                    // maxLines: 9999,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 90,
                          width: 9,
                          top: 44,
                          //bottom: 11,
                          child: Image.asset(
                            'res/images/image7_3359.png',
                            width: 9,
                            height: 9,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          width: 390,
                          top: 0,
                          height: 115,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 334,
                                width: 36,
                                top: 62,
                                height: 36,
                                child: Image.asset(
                                  'res/images/image1_I336060111.png',
                                  width: 36,
                                  height: 36,
                                ),
                              ),
                              Positioned(
                                left: 20,
                                width: 36,
                                top: 62,
                                height: 36,
                                child: Image.asset(
                                  'res/images/image2_I336060113.png',
                                  width: 36,
                                  height: 36,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                width: 390,
                                top: 0,
                                height: 46,
                                child: Image.asset(
                                  'res/images/image3_I336060115.png',
                                  width: 390,
                                  height: 46,
                                ),
                              ),
                              const Positioned(
                                left: 147,
                                top: 58,
                                child: Text(
                                  'GEN-Z',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    //decoration: TextDecoration.none,
                                    fontSize: 36,
                                    color: Color(0xff474672),
                                    fontFamily: 'AkayaKanadaka',
                                    //fontWeight: FontWeight.normal
                                  ),
                                  // maxLines: 9999,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 331,
                          top: 84,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffd42222),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 8, top: 1, right: 8, bottom: 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '4',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 12,
                                            color: Color(0xffffffff),
                                            fontFamily: 'SourceSans3',
                                            fontWeight: FontWeight.w600),
                                        // maxLines: 9999,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 173,
                          width: 186,
                          top: 150,
                          height: 104,
                          child: Image.asset(
                            'res/images/image8_5949.png',
                            width: 186,
                            height: 104,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 15,
                left: 20,
              ),
              child: Row(
                children: [
                  Text(
                    'Hello, ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      color: Color(0xff010911),
                      fontFamily: 'SourceSans3',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Blee',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        color: Color(0xff010911),
                        fontFamily: 'SourceSans3',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 28, right: 28),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            child: GestureDetector(
                              onTap: () {
                                // Lấy vị trí của widget cần cuộn đến trên màn hình
                                RenderBox? renderBox;
                                if (_targetWidgetKey.currentContext != null) {
                                  renderBox = _targetWidgetKey.currentContext!
                                      .findRenderObject() as RenderBox?;
                                }
                                double targetPosition =
                                    renderBox?.localToGlobal(Offset.zero).dy ??
                                        0.0;

                                // Cuộn đến vị trí của widget cần cuộn đến
                                _scrollController.animateTo(
                                  targetPosition,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset("res/images/image1_3370.png"),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      'Personality',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'SourceSans3',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            child: Column(
                              children: [
                                Image.asset("res/images/image2_3434.png"),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Nutrition',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'SourceSans3',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            child: Column(
                              children: [
                                Image.asset("res/images/image3_3502.png"),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Mental Health',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'SourceSans3',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            child: Column(
                              children: [
                                Image.asset("res/images/image4_3548.png"),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Drug',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'SourceSans3',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            child: Column(
                              children: [
                                Image.asset("res/images/image6_15428.png"),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Period Tracking',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'SourceSans3',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            child: Column(
                              children: [
                                Image.asset("res/images/image7_15493.png"),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Symptom',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'SourceSans3',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            child: Column(
                              children: [
                                Image.asset("res/images/image8_15495.png"),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Forum',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'SourceSans3',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: constraint.maxWidth /
                                4, // Chia đều không gian cho 4 cột
                            // child: Column(
                            //   children: [
                            //     Image.asset(
                            //         "res/images/image4_3548.png"),
                            //     Padding(
                            //       padding: EdgeInsets.only(top: 5),
                            //       child: Text(
                            //         'Drug',
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           color:
                            //               Color.fromARGB(255, 0, 0, 0),
                            //           fontFamily: 'SourceSans3',
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 26, right: 20),
              child: Row(
                children: [
                  const Text(
                    'Post',
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff010911),
                        fontFamily: 'SourceSans3',
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const Text(
                    'all',
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff010911),
                        fontFamily: 'SourceSans3',
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Image.asset("res/images/Icon1.png"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const CarouselSliderWithDots(),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 20),
              child: Row(
                key: _targetWidgetKey,
                children: const <Widget>[
                  Text(
                    'Personality',
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff010911),
                        fontFamily: 'SourceSans3',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 28, right: 28),
              child: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 210,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              HexColor('#FFB094'),
                              HexColor('#FFE5F8'),
                            ],
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12, top: 14),
                                child: Text(
                                  "Nutrion",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Card.filled(
                                          elevation: 0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Breakfast",
                                                  style: TextStyle(
                                                      fontFamily: "SourceSans3",
                                                      fontSize: 12,
                                                      color:
                                                          HexColor("F18872")),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Táo",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "95kcal",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 11,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Táo",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "95kcal",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Card.filled(
                                          elevation: 0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Lunch",
                                                  style: TextStyle(
                                                      fontFamily: "SourceSans3",
                                                      fontSize: 12,
                                                      color:
                                                          HexColor("F18872")),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Táo",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "95kcal",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 11,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Táo",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "95kcal",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Card.filled(
                                          elevation: 0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Dinner",
                                                  style: TextStyle(
                                                      fontFamily: "SourceSans3",
                                                      fontSize: 12,
                                                      color:
                                                          HexColor("F18872")),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Táo",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "95kcal",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 11,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Táo",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "95kcal",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "SourceSans3",
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              )
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 210,
                      child: Container(
                        // padding: EdgeInsets.all(0),
                        // margin: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: HexColor('FBAE9E'), width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: 9, right: 9, bottom: 25),
                                dense: true,
                                leading: const Text(
                                  "Water",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Image.asset(
                                  "res/images/Water.png",
                                  fit: BoxFit.cover,
                                  width: 16,
                                  height: 20,
                                )),
                            SizedBox(
                                height: 64,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 40,
                                        lineWidth: 6,
                                        backgroundColor: HexColor("F3F4F7"),
                                        progressColor: HexColor("FDBCA5"),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        percent: 0.4,
                                      ),
                                    ])),
                            Padding(
                              padding: const EdgeInsets.only(left: 9, top: 37),
                              child: Row(
                                children: [
                                  const Text(
                                    "1000",
                                    style: TextStyle(
                                        fontFamily: "SourceSans3",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "ml",
                                    style: TextStyle(
                                        fontFamily: "SourceSans3",
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 28, right: 28),
              child: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 267,
                      child: Column(
                        children: [
                          Container(
                            height: 147,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: HexColor('FBAE9E'), width: 3),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.only(
                                      left: 9,
                                      right: 9,
                                    ),
                                    dense: true,
                                    leading: const Text(
                                      "Walk",
                                      style: TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    trailing: Image.asset(
                                      "res/images/walk.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  SizedBox(
                                      height: 82,
                                      child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircularPercentIndicator(
                                              radius: 40,
                                              lineWidth: 6,
                                              backgroundColor:
                                                  HexColor("F3F4F7"),
                                              progressColor: HexColor("FDBCA5"),
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              percent: 0.4,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  '5460',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  'steps',
                                                  style: TextStyle(
                                                      fontFamily: 'SourceSans3',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                                ),
                                              ],
                                            ),
                                          ])),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: HexColor('FBAE9E'), width: 3),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.only(
                                      left: 9,
                                      right: 9,
                                    ),
                                    dense: true,
                                    leading: const Text(
                                      "Sleep",
                                      style: TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    trailing: Image.asset(
                                      "res/images/Bed.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 9, top: 15),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "8",
                                          style: TextStyle(
                                              fontFamily: "SourceSans3",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "hours",
                                          style: TextStyle(
                                              fontFamily: "SourceSans3",
                                              fontSize: 12,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 267,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              HexColor('#FFFFFF'),
                              HexColor('#EDEFF7'),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 25),
                                dense: true,
                                leading: const Text(
                                  "Calories",
                                  style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Image.asset(
                                  "res/images/Calories.png",
                                  fit: BoxFit.cover,
                                  width: 16,
                                  height: 20,
                                )),
                            SizedBox(
                                width: 50,
                                //height: 64,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 40,
                                        lineWidth: 6,
                                        backgroundColor: HexColor("F3F4F7"),
                                        progressColor: HexColor("BBB7EA"),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        percent: 0.4,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '5460',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'needed',
                                            style: TextStyle(
                                                fontFamily: 'SourceSans3',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ])),
                            const SizedBox(
                              height: 38,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '5460',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'in',
                                      style: TextStyle(
                                          fontFamily: 'SourceSans3',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '5460',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'out',
                                      style: TextStyle(
                                          fontFamily: 'SourceSans3',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 110,
            )
          ]),
        ),
      ),
    ]);
  }
}
