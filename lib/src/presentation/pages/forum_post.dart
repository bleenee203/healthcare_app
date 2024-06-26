import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MaterialApp(home: ForumPost()));
}

class ForumPost extends StatefulWidget {
  const ForumPost({super.key});

  @override
  State<StatefulWidget> createState() => _ForumPost();
}

class _ForumPost extends State<ForumPost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          color: const Color(0xfffbedec),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 66),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      "FORUM",
                      style: TextStyle(
                        color: HexColor("474672"),
                        fontFamily: "SourceSans3",
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Image.asset("res/images/noti.png"),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: HexColor("#FFC3B4"),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFBAE9E),
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid,),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26, // Bóng đổ bên trong
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Đau nửa đầu",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("000000"),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "lyvo13",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("000000"),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "00/00/00",
                                style: TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("000000"),
                                ),
                              ),
                            ],
                          ),
                          const Image(image: AssetImage("res/images/message.png"),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        children: [
                          Text(
                            "Tôi thường xuyên bị đau nữa đầu vào chiều tối. Đây là triệu chứng của bệnh gì?",
                            style: TextStyle(
                              fontFamily: "SourceSans3",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: HexColor("000000"),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(child: Image.asset('res/images/dog.png',
                          width: 310,
                          height: 113,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Comments",
                style: TextStyle(
                  fontFamily: "SourceSans3",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              ListView(
                children: [
                  _buildComment("lyvo13", "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                  _buildComment("lyvo13", "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                  _buildComment("lyvo13", "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildComment(String userId, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: HexColor("#F8BBD0"),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "@$userId",
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HexColor("000000"),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.chat_bubble_outline, color: Colors.black),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              comment,
              style: TextStyle(
                fontFamily: "SourceSans3",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: HexColor("000000"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
