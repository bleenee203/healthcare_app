import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../router/router.dart';

class SelectExercise extends StatefulWidget {
  const SelectExercise({super.key});

  @override
  State<SelectExercise> createState() => _SelectExerciseState();
}

class _SelectExerciseState extends State<SelectExercise> {
  @override
  Widget build(BuildContext context) {
    return const ActivityScreen();
  }
}

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  void _showDialog(BuildContext context, String acti) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Log or Start Tracking',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0,
                          fontFamily: "SourceSans3",
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                RouterCustom.router.push('/log-exercise/$acti');
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 20.0)),
                              ),
                              child: Text(
                                "Log $acti",
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                RouterCustom.router.push('/step-count/$acti');
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 20.0)),
                              ),
                              child: Text(
                                "Start tracking $acti",
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
              const SizedBox(
                height: 35,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 34.0,
                  shrinkWrap: true,
                  children: [
                    _buildActivityCard(
                        context, 'Run', 'res/images/run.png', true),
                    _buildActivityCard(
                        context, 'Workout', 'res/images/workout.png', false),
                    _buildActivityCard(
                        context, 'Swim', 'res/images/swim.png', false),
                    _buildActivityCard(
                        context, 'Bike', 'res/images/bike.png', false),
                    _buildActivityCard(
                        context, 'Sport', 'res/images/sport.png', false),
                    _buildActivityCard(
                        context, 'Walk', 'res/images/walking.png', true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(
      BuildContext context, String title, String imageLink, bool isWalking) {
    return GestureDetector(
      onTap: () {
        if (isWalking) {
          _showDialog(context, title);
        } else {
          RouterCustom.router.push('/log-exercise/$title');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Color(0xFFFBAE9E), width: 3),
        ),
        padding: EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                child: Image(
                  image: AssetImage(imageLink),
                  height: 64,
                  width: 64,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
