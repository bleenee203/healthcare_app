import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/Animation/FadeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;
  late SharedPreferences prefs;
  final dio = Dio();

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void loginUser() async {
    if (emailController.value.text.isNotEmpty &&
        passController.value.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.value.text,
        "password": passController.value.text
      };
      var url = dotenv.env['URL'];
      var response = await http.post(Uri.parse('${url}user/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      print(reqBody);
      print(jsonResponse);
      if (jsonResponse['success'] != null) {
        if (jsonResponse['success']) {
          if (response.headers['set-cookie'] != null) {
            var refreshToken = response.headers['set-cookie'];
            prefs.setString('refreshToken', refreshToken!);
          }
          prefs.setString('accessToken', jsonResponse['accessToken']);
          prefs.setString('email', jsonResponse['loginuser']['email']);
          print(prefs.getString('refreshToken'));
          // Sử dụng:
          //LoadingOverlay.show(context);
          context.pushNamed('tabs');
          //LoadingOverlay.hide();
        } else {
          print('Something went wrong');
        }
      } else {
        String mess = jsonResponse['feedback'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(mess)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color(0xFFFBEDEC),
              Color(0xFFD37FE0),
            ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FadeAnimation(
                  2,
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Image.asset('res/images/login-img.png'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeAnimation(
                      2,
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontFamily: 'SourceSans3',
                          fontSize: 20,
                          color: Color(0xFF77258B),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FadeAnimation(
                      2,
                      const Text(
                        "Please, Log In",
                        style: TextStyle(
                          fontFamily: 'SourceSans3',
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(
                        2,
                        Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              prefixIcon:
                                  Image.asset('res/images/user-icon.png'),
                              hintText: "Email",
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              bool _isEmailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value ?? '');
                              if (value!.isEmpty) {
                                return "Enter Email";
                              }
                              if (!_isEmailValid) {
                                return 'Invalid email format'; // Trả về thông báo lỗi
                              }
                              return null; // Email hợp lệ
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        2,
                        Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            obscureText: passToggle,
                            controller: passController,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              prefixIcon:
                                  Image.asset('res/images/key-icon.png'),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Icon(passToggle
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              bool isPasswordValid = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#_\\$&*~]).{8,}$')
                                  .hasMatch(value ?? '');
                              if (value!.isEmpty) {
                                return "Require password!";
                              }
                              if (!isPasswordValid) {
                                // Nếu mật khẩu không hợp lệ, hiển thị thông báo và không thực hiện đăng nhập.
                                return "Passwords must be at least 8 characters long, include uppercase letters and special characters.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeAnimation(
                            2,
                            SizedBox(
                              width: 162,
                              child: ElevatedButton(
                                  onPressed: () {}, //Để đây sử sau
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3B5999),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset('res/images/facebook.png'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Facebook",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SourceSans3'),
                                        ),
                                      ])),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          FadeAnimation(
                            2,
                            SizedBox(
                              width: 162,
                              child: ElevatedButton(
                                  onPressed: () {}, //Để đây sử sau
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDE4B39),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset('res/images/google.png'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Google",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SourceSans3'),
                                        ),
                                      ])),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        2,
                        SizedBox(
                          width: 350,
                          height: 56,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  loginUser();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF77258B),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SourceSans3'),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      FadeAnimation(
                        2,
                        TextButton(
                          onPressed: () {
                            context.pushNamed('register');
                          } //Tính sau nhen
                          ,
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 1, // Chiều cao 1 pixel
                            color: Colors.white, child: null, // Màu xám
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Or",
                            style: TextStyle(
                              fontFamily: 'SourceSans3',
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 150,
                            height: 1, // Chiều cao 1 pixel
                            color: Colors.white, child: null, // Màu xám
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        2,
                        Container(
                          width: 350,
                          height: 68,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF77258B),
                                  blurRadius: 20,
                                  offset: Offset(0, 8)),
                            ],
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                context.goNamed('signup');
                              }, //Để đây sử sau
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD19ADB),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Text(
                                "Create an Account",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SourceSans3'),
                              )),
                        ),
                      ),
                    ],
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
