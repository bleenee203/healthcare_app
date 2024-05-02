import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class Verify2 extends StatefulWidget {
  const Verify2({super.key, this.mail});
  final mail;


  @override
  _Verify2State createState() => _Verify2State();
}

class _Verify2State extends State<Verify2> {
  int _remainingSeconds = 60;
  bool resendButtonEnabled = false;
  List<String> otpValues = List.generate(6, (index) => "");

  void verifyUser() async {
    String otp = otpValues.join();
    int otpInt = int.parse(otp);
    String email = widget.mail.toString();
    var regBody = {
      "email": email,
      "otp": otpInt,
    };
    var response = await http.post(Uri.parse("${url}user/verifyotp"),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(regBody)
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonEncode(regBody));
    print(jsonResponse['success']);
    if (jsonResponse['success']) {
      context.push('/resetpass/$email');
    } else {
      print("SomeThing Went Wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    startCountdown(); // Bắt đầu đếm ngược ngay khi widget được khởi tạo
  }
  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          resendButtonEnabled = true; // Khi đếm về 0, enable nút "Resend New Code"
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }
  String _remainingSecondsToString() {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void restartCountdown() {
    setState(() {
      _remainingSeconds = 60; // Thiết lập lại thời gian đếm ngược về giá trị ban đầu
      resendButtonEnabled = false; // Vô hiệu hóa nút "Resend New Code"
    });
    startCountdown(); // Bắt đầu lại bộ đếm
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('FBEDEC'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  // color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'res/images/GEN-Z.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verify',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'SourceSans3',
                  color: Color(0xFF77258B),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We have sent an OTP on your email Maibaoxt1@gmail.com",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF77258B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Resend code in ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF77258B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(_remainingSecondsToString(), style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF77258B),
                  ),),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xffFBEDEC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(
                            first: true, last: false, index: 0 ,context: context),
                        _textFieldOTP(
                            first: false, last: false, index: 1, context: context),
                        _textFieldOTP(
                            first: false, last: false, index: 2, context: context),
                        _textFieldOTP(
                            first: false, last: false, index: 3, context: context),
                        _textFieldOTP(
                            first: false, last: false, index: 4, context: context),
                        _textFieldOTP(
                            first: false, last: true, index: 5, context: context),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: 242,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          verifyUser();
                        },
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFFF8C74)),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              Visibility(
                visible: resendButtonEnabled,
                child: TextButton(
                  onPressed:  () {
                    restartCountdown();
                    verifyUser();
                  },
                  child: const Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first, last, index, required BuildContext context}) {
    return SizedBox(
      height: 45,
      width: 40,
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          otpValues[index] = value;
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
          // Loại bỏ lề nội dung
          counter: const Offstage(),
          filled: true,
          // Bật màu nền
          fillColor: Colors.white,
          // Màu nền của ô OTP
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.purple),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
