import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

import '../../../Animation/FadeAnimation.dart';
import 'config.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});

  final email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  bool passToggle = true;
  bool confirmToggle = true;

  void resetPass() async {
    if (passController.text.isNotEmpty) {
      final mail = widget.email;

      var regBody = {
        "email": mail,
        "password": passController.value.text
      };
      try {
        var response = await http.patch(Uri.parse("${url}user/resetpass"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));
        var jsonResponse = jsonDecode(response.body);
        print(jsonEncode(regBody));
        print(jsonResponse);
        print(jsonResponse['success']);
        if (jsonResponse['success']) {
          context.go('/succes');
        } else {
          print("SomeThing Went Wrong");
        }
      } catch (e) {
        print("Lỗi: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            width: double.infinity,
            height: double.infinity,
            color: Color(0xFFFBEDEC),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => context.goNamed('register'),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 32,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "CHANGE PASSWORD",
                      style: TextStyle(
                        fontFamily: 'SourceSan3',
                        fontSize: 25,
                        color: Color(0xFF474672),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Image.asset('res/images/passkey.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: passController,
                          obscureText: passToggle,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "New password",
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Image.asset('res/images/passkey.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          obscureText: confirmToggle,
                          controller: confirmController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Confirm Neww Password",
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
                                  confirmToggle = !confirmToggle;
                                });
                              },
                              child: Container(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Icon(confirmToggle ? Icons.visibility : Icons.visibility_off)),
                            ),
                          ),
                          validator: (value){
                            if (value != passController.value.text) {
                              return "Mật khẩu không trùng khớp!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 350,
                  height: 56,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Thay đổi thành công')),
                          );
                          resetPass();
                        }
                      }, //Để đây sử sau
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF474672),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                      child: const Text(
                        "UPDATE PASSWORD",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SourceSans3'),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  height: 56,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.goNamed('login');
                        }
                      }, //Để đây sử sau
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFCD4D1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SourceSans3'),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
