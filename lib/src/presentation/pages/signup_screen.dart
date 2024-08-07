
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/Animation/FadeAnimation.dart';

import '../../services/auth_services.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final bool _isNotValidate = false;

  bool passToggle = true;
  bool confirmPassToggle = true;


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
                  height: 5,
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeAnimation(
                      2,
                      Text(
                        "Hi There!",
                        style: TextStyle(
                          fontFamily: 'SourceSans3',
                          fontSize: 20,
                          color: Color(0xFF77258B),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FadeAnimation(
                      2,
                      Text(
                        "Let's Get Started",
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
                              bool isEmailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value ?? '');
                              if (value!.isEmpty) {
                                return "Enter Email";
                              }
                              if (!isEmailValid) {
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
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
                            keyboardType: TextInputType.text,
                            obscureText: passToggle,
                            validator: (value) {
                              bool isPasswordValid = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#_\\$&*~]).{8,}$')
                                  .hasMatch(value ?? '');
                              if (value!.isEmpty) {
                                return "Not entered password";
                              }
                              if (!isPasswordValid) {
                                // Nếu mật khẩu không hợp lệ, hiển thị thông báo và không thực hiện đăng nhập.
                                return "The password must be at least 8 characters long, contain uppercase letters, and special characters";
                              }
                              return null;
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            controller: confirmPassController,
                            obscureText: confirmPassToggle,
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
                              hintText: "Confirm Password",
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
                                    confirmPassToggle = !confirmPassToggle;
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Icon(confirmPassToggle
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value != passController.value.text) {
                                return "Passwords do not match!";
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
                                  registerUser(emailController, passController, confirmPassController, context);
                                }
                              }, //Để đây sử sau
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF77258B),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Create An Account ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'SourceSans3'),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.chevron_right),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                                context.goNamed('login');
                              }, //Để đây sử sau
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD19ADB),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Text(
                                "Login",
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
