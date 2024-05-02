import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'config.dart';
import 'overlay.dart';
import 'verify_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void forgotPass() async {
    if (emailController.text.isNotEmpty ) {
      final mail = emailController.value.text;

      var regBody = {
        "email": emailController.value.text,
      };
      try {
        var response = await http.post(Uri.parse("${url}user/forgotpass"),
            headers: {"Content-Type":"application/json"},
            body: jsonEncode(regBody)
        );
        var jsonResponse = jsonDecode(response.body);
        print(jsonEncode(regBody));
        print(jsonResponse);
        print(jsonResponse['succes']);
        if (jsonResponse['succes']) {
          // Sử dụng:
          LoadingOverlay.show(context);
          context.push('/verify2/$mail');
          LoadingOverlay.hide();
        } else {
          print("SomeThing Went Wrong");
        }
      }
      catch (e) {
        print("Lỗi: $e");
      }
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffFBEDEC),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'res/images/login-img.png',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Add your EMAIL. We'll send you a verification code so we know you're real",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Image.asset(
                                'res/images/email.png',
                              ),
                            ),
                            // suffixIcon: const Icon(
                            //   Icons.check_circle,
                            //   color: Colors.green,
                            //   size: 32,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              forgotPass();
                            },
                            style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFFFF8C74)),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Send',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }