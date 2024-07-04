import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:audioplayers/audioplayers.dart';

class BeginSleepPage extends StatefulWidget {
  final hour;
  final min;

  const BeginSleepPage(this.hour, this.min, {super.key});

  @override
  State<StatefulWidget> createState() => _BeginSleepPage();
}

class _BeginSleepPage extends State<BeginSleepPage> {
  late int _remainingSeconds;
  Timer? _timer;
  late AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.hour * 3600 + widget.min * 60;
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    startCountdown(); // Bắt đầu đếm ngược ngay khi widget được khởi tạo
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        _triggerAlarm();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  Future<void> _triggerAlarm() async {
    // Phát âm thanh báo thức
    await _audioPlayer.play(AssetSource("../res/sounds/alarm_sound.mp3",), );
  }

  String _remainingSecondsToString() {
    final hours = _remainingSeconds ~/ 3600;
    final minutes = (_remainingSeconds % 3600) ~/ 60;
    final seconds = _remainingSeconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: HexColor("FBEDEC"),
          height: double.infinity,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "res/images/Begin_Sleep_Now.png",
              ),
              fit: BoxFit.fill,
            )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.7,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      _remainingSecondsToString(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontFamily: "SourceSans3",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "TIME IN BED",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "SourceSans3",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(344, 46),
                      padding: const EdgeInsets.fromLTRB(68, 0, 68, 0),
                      backgroundColor: const Color(0xFF474672),
                    ),
                    onPressed: () {
                      print("${widget.hour} : ${widget.min}");
                      _timer?.cancel();
                      _audioPlayer.stop();
                      // Quay lại trang trước đó
                      if (RouterCustom.router.canPop()) {
                        RouterCustom.router.pop();
                      }
                      // Handle set goal
                    },
                    child: Text(
                      'i\'m wake'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "SourceSans3",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
