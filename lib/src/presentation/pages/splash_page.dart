import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../Animation/FadeAnimation.dart';

String? finalToken;

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    getValidationData().whenComplete(() async {
      Future.delayed(const Duration(milliseconds: 3000), () {
        bool isExpired = finalToken == null ? true : JwtDecoder.isExpired(finalToken!);
        context.go(isExpired ? '/login' : '/tabs');
      });
    });
  }

  Future<void> getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtained = prefs.getString('refreshToken');
    setState(() {
      finalToken = obtained;
    });
    print(finalToken);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFBEDEC),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'res/images/GEN-Z.png',
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            FadeAnimation(
              1,
              const SizedBox(
                width: 300,
                child: Align(
                  child: Text(
                    "Let Us Accompany You On Your Personal Growth",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Playfair',
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
