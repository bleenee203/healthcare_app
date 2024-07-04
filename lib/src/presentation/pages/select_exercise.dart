import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../router/router.dart';

class SelectExercise extends StatelessWidget {
  const SelectExercise({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityScreen();
  }
}

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color(0xfffbedec),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 20,
                  ),
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
                        "exercise".toUpperCase(),
                        style: TextStyle(
                          color: HexColor("474672"),
                          fontFamily: "SourceSans3",
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Align(
                          alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35,),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 34.0,
                  shrinkWrap: true,
                  children: [
                    _buildActivityCard('Run', 'res/images/run.png'),
                    _buildActivityCard('Workout', 'res/images/workout.png'),
                    _buildActivityCard('Swim', 'res/images/swim.png'),
                    _buildActivityCard('Bike', 'res/images/bike.png'),
                    _buildActivityCard('Sport', 'res/images/sport.png'),
                    _buildActivityCard('Walk', 'res/images/walking.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String imageLink) {
    return GestureDetector(
      onTap: (){
          RouterCustom.router.pushNamed('log-exercise');
      },
      child: Container(
        // height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Color(0xFFFBAE9E), width: 3),

        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: "SourceSans3",
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image(image:AssetImage(imageLink),
              height: 64,
              width: 64,),
            ),
          ],
        ),
      ),
    );
  }
}
