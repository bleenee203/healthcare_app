import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/Animation/FadeAnimation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
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
                const SizedBox(height: 15,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeAnimation(2,
                      const Text("Welcome Back",
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
                      const Text("Please, Log In",
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
                const SizedBox(height: 40,),
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 10 , 0),
                          child: Row(
                            children: <Widget>[
                               Image.asset('res/images/user-icon.png'),
                               SizedBox(width: 10,),
                               const Expanded(
                                 child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Phone number",
                                    hintStyle: TextStyle(
                                      fontFamily: 'SourceSans3',
                                      fontSize: 14,
                                      color: Color(0x80000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                 ),
                               ),
                            ],
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 10 , 0),
                          child: Row(
                            children: <Widget>[
                              Image.asset('res/images/key-icon.png'),
                              const SizedBox(width: 10,),
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      fontFamily: 'SourceSans3',
                                      fontSize: 14,
                                      color: Color(0x80000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
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
                          child: ElevatedButton(onPressed: (){
                            context.goNamed('tabs');
                          }, //Để đây sử sau
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF77258B),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SourceSans3'
                                ),
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 0,),
                      FadeAnimation(2,
                        TextButton(onPressed: (){} //Tính sau nhen
                            , child: const Text("Forget Password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 0,),
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
                            context.goNamed('signup');
                          }, //Để đây sử sau
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD19ADB),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                              child: const Text(
                                "Create an Account",
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
      );
  }
}


