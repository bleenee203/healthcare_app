import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/userService.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  final currentController = TextEditingController();
  bool passToggle = true;
  bool confirmToggle = true;
  bool currentToggle = true;

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Container(
            height: double.infinity,
            color: const Color(0xfffbedec),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (RouterCustom.router.canPop()) {
                              RouterCustom.router.pop();
                            }
                          },
                          child: Image.asset('res/images/go-back.png'),
                        ),
                        Text(
                          "CHANGE PASSWORD",
                          style: TextStyle(
                            color: HexColor("474672"),
                            fontFamily: "SourceSans3",
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Image.asset("res/images/noti.png"),
                      ],
                    ),
                  ),
                  Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                        child: Row(
                          children: [
                            Image.asset("res/images/current-pass.png"),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: currentController,
                                obscureText: currentToggle,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Current password',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorMaxLines: 2,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentToggle = !currentToggle;
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Icon(currentToggle
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                  ),
                                ),
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
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                        child: Row(
                          children: [
                            Image.asset("res/images/passkey.png"),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: passController,
                                obscureText: passToggle,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'New password',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorMaxLines: 2,
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
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                        child: Row(
                          children: [
                            Image.asset("res/images/passkey.png"),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                obscureText: confirmToggle,
                                controller: confirmController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Confirmed password',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorMaxLines: 2,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        confirmToggle = !confirmToggle;
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Icon(confirmToggle
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value != passController.value.text) {
                                    return "Password does not match!";
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final mail = prefs.getString('email');
                        if (mail == null) {
                          print('Missing access mail');
                          return;
                        }

                        UserService().changePass(
                            mail, currentController, passController, context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("474672")),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "UPDATE PASSWORD",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/tabs');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("FCD4D1")),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed('register');
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      "Forgot Password?",
                      style: TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: HexColor("FE7B60")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
