import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:healthcare_app/Animation/FadeAnimation.dart';

class Success extends StatefulWidget{
  const Success({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SuccessState();
  }

}

class _SuccessState extends State<Success>{
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(milliseconds: 3000,), () {
      context.goNamed('login');
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 100,),
          Lottie.asset('./res/images/success.json'),
          const SizedBox(height: 50,),
          const FadeAnimation(2,
            Text("Email registered",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SourceSans3',
              ),),
          ),
          const SizedBox(height: 30),
          const FadeAnimation(2,
            Text("Successfully!",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'SourceSans3',
                color: Color(0xFF0099FF),
              ),),
          ),
        ],
      ),
    );
  }
}