import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 100,),
          Lottie.network('https://lottie.host/6d5b4958-4205-42ec-9b4b-9a712e8ac677/hh4R3Is3eQ.json'),
          const SizedBox(height: 50,),
          FadeAnimation(2,
            const Text("Phone number registered",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SourceSans3',
              ),),
          ),
          const SizedBox(height: 30),
          FadeAnimation(2,
            const Text("Successfully!",
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