import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_services.dart';

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
                            errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
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
                            errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorMaxLines: 2,
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
                              return "Password does not match!";
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
                          final mail = widget.email;
                          String pass = passController.value.text;
                          resetPass(mail, pass, context);
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
