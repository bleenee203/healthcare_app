import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;


import 'config.dart';
import 'overlay.dart';

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
  bool _isNotValidate = false;

  bool passToggle = true;
  bool confirmPassToggle = true;

  void registerUser() async{
    if(emailController.text.isNotEmpty && passController.text.isNotEmpty && confirmPassController.text.isNotEmpty){
      final pass = passController.value.text;
      final mail = emailController.value.text;
      var regBody = {
        "email": emailController.value.text,
      };
      var response = await http.post(Uri.parse("${url}user/sendotp"),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] != null){
        print(jsonResponse['success']);
        if(jsonResponse['success']){
          // Sử dụng:
          LoadingOverlay.show(context);
          context.go('/verify/$mail/$pass');
          LoadingOverlay.hide();
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonResponse['message'])),
          );
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error')),
        );
      }
    }else{
      setState(() {
        _isNotValidate = true;
      });
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
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color(0xFFFBEDEC),
                  Color(0xFFD37FE0),
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FadeAnimation(2,
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Image.asset('res/images/login-img.png'),
                  ),
                ),
                const SizedBox(height: 5,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeAnimation(2,
                      const Text("Hi There!",
                        style: TextStyle(
                          fontFamily: 'SourceSans3',
                          fontSize: 20,
                          color: Color(0xFF77258B),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    FadeAnimation(2,
                      const Text("Let's Get Started",
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
                const SizedBox(height:40,),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(2,
                        Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0 , 0),
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
                              prefixIcon: Image.asset('res/images/user-icon.png'),
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
                              if (value!.isEmpty){
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
                      const SizedBox(height: 20,),
                      FadeAnimation(2,
                        Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0 , 0),
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
                              contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              prefixIcon: Image.asset('res/images/key-icon.png'),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Icon(passToggle ? Icons.visibility : Icons.visibility_off)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: passToggle,
                            validator: (value){
                              bool isPasswordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#_\\$&*~]).{8,}$')
                                  .hasMatch(value ?? '');
                              if (value!.isEmpty) {
                                return "Chưa nhập mật khẩu";
                              }
                              if (!isPasswordValid) {
                                // Nếu mật khẩu không hợp lệ, hiển thị thông báo và không thực hiện đăng nhập.
                                return "Mật khẩu cần phải có tối thiểu 8 kí tự, phải gồm chữ in hoa và ký tự đặc biệt";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      FadeAnimation(2,
                        Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0 , 0),
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
                              contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              prefixIcon: Image.asset('res/images/key-icon.png'),
                              hintText: "Confirm Password",
                              hintStyle: const TextStyle(
                                fontFamily: 'SourceSans3',
                                fontSize: 14,
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    confirmPassToggle = !confirmPassToggle;
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Icon(confirmPassToggle ? Icons.visibility : Icons.visibility_off)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if (value != passController.value.text) {
                                return "Mật khẩu không trùng khớp!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeAnimation(2,
                            SizedBox(
                              width: 162,
                              child: ElevatedButton(onPressed: (){}, //Để đây sử sau
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3B5999),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset('res/images/facebook.png'),
                                        const SizedBox(width: 10,),
                                        const Text(
                                          "Facebook",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SourceSans3'
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          FadeAnimation(2,
                            SizedBox(
                              width: 162,
                              child: ElevatedButton(onPressed: (){}, //Để đây sử sau
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDE4B39),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset('res/images/google.png'),
                                        const SizedBox(width: 10,),
                                        const Text(
                                          "Google",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SourceSans3'
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      FadeAnimation(2,
                        SizedBox(
                          width: 350,
                          height: 56,
                          child: ElevatedButton(onPressed: () async {
                            if (_formKey.currentState!.validate()) {

                              registerUser();
                            }
                          }, //Để đây sử sau
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF77258B),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Create An Account ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'SourceSans3'
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(Icons.chevron_right),
                                ],
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
                          Container(
                            width: 150,
                            height: 1, // Chiều cao 1 pixel
                            color: Colors.white, child: null, // Màu xám
                          ),
                          const SizedBox(width: 5,),
                          const Text("Or",
                            style: TextStyle(
                              fontFamily: 'SourceSans3',
                              color: Colors.white,
                              fontSize: 20,

                            ),
                          ),
                          const SizedBox(width: 5,),
                          Container(
                            width: 150,
                            height: 1, // Chiều cao 1 pixel
                            color: Colors.white, child: null, // Màu xám
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      FadeAnimation(2,
                        Container(
                          width: 350,
                          height: 68,
                          decoration: const BoxDecoration(
                            boxShadow: [BoxShadow(
                                color: Color(0xFF77258B),
                                blurRadius: 20,
                                offset: Offset(0, 8)
                            ),],
                          ),
                          child: ElevatedButton(onPressed: (){
                            context.goNamed('login');
                          }, //Để đây sử sau
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD19ADB),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SourceSans3'
                                ),
                              )
                          ),
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


