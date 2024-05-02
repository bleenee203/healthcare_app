import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});
  @override
  State<StatefulWidget> createState() => _ChnagePasswordPage();
}

class _ChnagePasswordPage extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
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
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Current password',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none),
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
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'New password',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none),
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
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Confirmed password',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "SourceSans3",
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {},
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
                  onPressed: () {},
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
                Text(
                  textAlign: TextAlign.center,
                  "Forgot Password?",
                  style: TextStyle(
                      fontFamily: "SourceSans3",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: HexColor("FE7B60")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
