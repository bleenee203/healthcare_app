import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../Animation/FadeAnimation.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

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
            color: Color(0xFFFCD4D1),
            child: Column(children: <Widget>[
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
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "New password",
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
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Confirm Neww Password",
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
              const SizedBox(height: 50,),
              SizedBox(
                width: 350,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Thay đổi thành công')),
                        );
                        context.goNamed('success');
                      }

                    }, //Để đây sử sau
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF474672),
                      foregroundColor: Colors.white,
                      padding:
                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    ),
                    child: const Text(
                      "UPDATE PASSWORD",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SourceSans3'),
                    )),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 350,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Thay đổi thành công')),
                        );
                        context.goNamed('success');
                      }

                    }, //Để đây sử sau
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFE7B60),
                      foregroundColor: Colors.white,
                      padding:
                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
