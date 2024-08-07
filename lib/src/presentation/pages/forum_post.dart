import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/postModel.dart';
import '../../services/postServices.dart';

class ForumPost extends StatefulWidget {
  final id;

  const ForumPost({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _ForumPost();
}

class _ForumPost extends State<ForumPost> {
  List<Map<String, String>> comments = [];
  List<Map<String, String>> replies = [];
  PostService postService = PostService();
  Future<Post?>? data;

  Future<List<Post>?> _fetchPost() async {
    final List<Post>? response = await postService.fetchPost();
    if (response!.isEmpty) {
      return [];
    }
    return response;
  }

  Future<Post?> getPost(String id) async {
    final Post? response = await postService.getPost(id);
    if (response != null ) {
      return response;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    data = getPost(widget.id);
  }

  void _showCommentDialog() {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              controller: commentController,
              maxLines: null,
              decoration: const InputDecoration(hintText: 'Enter your comment'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  comments.add(
                      {'userId': 'User', 'comment': commentController.text});
                });
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showReplyDialog(String commentId) {
    TextEditingController replyController = TextEditingController();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Reply'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              controller: replyController,
              maxLines: null,
              decoration: const InputDecoration(hintText: 'Enter your reply'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  replies.add({
                    'commentId': commentId,
                    'userId': 'User',
                    'reply': replyController.text
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          color: const Color(0xfffbedec),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
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
                FutureBuilder<Post?>(
                  future: data,
                  builder:
                      (BuildContext context, AsyncSnapshot<Post?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No post found'));
                    } else {
                      final data = snapshot.data!;
                      return Container(
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
                                color: const Color(0xFFFBAE9E),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title,
                                        style: TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("000000"),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data.user_id ?? '',
                                        style: TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("000000"),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data.created_at.toString(),
                                        style: TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("000000"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      //Đây là nút comment
                                      onTap: _showCommentDialog,
                                      child: const Image(
                                        image: AssetImage(
                                            "res/images/message.png"),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.content,
                                    style: TextStyle(
                                      fontFamily: "SourceSans3",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: HexColor("000000"),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Center(
                                      child: Image.asset(
                                    'res/images/dog.png',
                                    width: 310,
                                    height: 113,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
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
                _buildComment("lyvo13",
                    "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                Positioned.fill(
                  child: CustomPaint(
                    painter: LinePainter(),
                  ),
                ),
                _buildReply("lyvo13",
                    "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                _buildComment("lyvo13",
                    "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                Positioned.fill(
                  child: CustomPaint(
                    painter: LinePainter(),
                  ),
                ),
                _buildReply("lyvo13",
                    "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                _buildComment("lyvo13",
                    "Đây có lẽ là bệnh ung thư. Bạn nên đi đến bệnh viện gần nhất để khám."),
                // ...comments.map((comment) => Column(
                //   children: [
                //     _buildComment(comment['userId']!, comment['comment']!),
                //     ...replies.where((reply) => reply['commentId'] == comment['userId']).map((reply) =>
                //         _buildReply(reply['userId']!, reply['reply']!)).toList(),
                //   ],
                // )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComment(String userId, String comment) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: HexColor("#FFE7C9D9"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFD4A7C7),
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
                      "@$userId",
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: HexColor("000000"),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showReplyDialog(userId),
                  child: const Image(
                    image: AssetImage("res/images/message.png"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                Text(
                  comment,
                  style: TextStyle(
                    fontFamily: "SourceSans3",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: HexColor("000000"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReply(String userId, String comment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFDAD1EB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFBBB7EA),
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
                          "@$userId",
                          style: TextStyle(
                            fontFamily: "SourceSans3",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: HexColor("000000"),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        {}
                      },
                      child: const Image(
                        image: AssetImage("res/images/message.png"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: [
                    Text(
                      comment,
                      style: TextStyle(
                        fontFamily: "SourceSans3",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: HexColor("000000"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double startX = 15;
    double endX = startX;
    double startY = 0;
    double endY = startY + 40;

    for (int i = 0; i < 1; i++) {
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      canvas.drawLine(Offset(endX, endY), Offset(endX + 32, endY), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
