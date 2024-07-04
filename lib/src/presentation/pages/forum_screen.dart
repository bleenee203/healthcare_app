import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(home: ForumPage()));
}

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForumPage();
}

class _ForumPage extends State<ForumPage> {
  File? _selectedImage;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> data = [
    {
      "user_id": "maibaoxt1",
      "title": "Đau nửa đầu",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "lyvo12",
      "title": "Nôn mửa tiêu chảy",
      "content":
          "Tôi hay bị nôn mửa tiêu chảy vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "nguyenhoang",
      "title": "Đau họng",
      "content": "Tôi hay bị đau họng vào sáng sớm và tối muộn. Xin tư vấn",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Đau nửa đầu",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Đau nửa đầu",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Đau nửa đầu",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Đau nửa đầu",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Đau nửa đầu",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Dau nua dau",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Dau nua dau",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Dau nua dau",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
    {
      "user_id": "maibaoxt1",
      "title": "Dau nua dau",
      "content": "Tôi hay bị đau nữa đầu vào chiều tối. Sáng hôm sau thì uể ỏi",
    },
  ];

  List<Map<String, String>> filteredData = [];
  int currentMax = 5;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    filteredData = data;
    _searchController.addListener(_filterThreads);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Hàm cho chưức năng tìm kiếm threads
  void _filterThreads() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredData = data.where((thread) {
        final title = thread['title']!.toLowerCase();
        return title.contains(query);
      }).toList();
    });
  }

  // Kết thúc những hàm cho chức năng tìm kiếm

  // Hàm xu li viec cuon trang
  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate a delay for loading more data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      currentMax = (currentMax + 5).clamp(0, data.length);
      filteredData = data.take(currentMax).toList();
      isLoading = false;
    });
  }

  // Ket thuc ham xu li viec cuon trang

  // Hàm chọn ảnh từ máy
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
    print("Đã chọn được ảnh");
  }

  void _showCreateThreadDialog() {
    final formKey = GlobalKey<FormState>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formKey,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: SizedBox(
              width: 500,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'New Topic',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22.0,
                            fontFamily: "SourceSans3",
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _titleController,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: "SourceSans3",
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Thread title',
                            hintText: "Type here",
                          ),
                          validator: (value){
                            if (value !.isEmpty){
                              return "Enter your title!";
                            }
                            return null;                        },
                        ),
                        const SizedBox(height: 60.0),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: "SourceSans3",
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: "Type here",
                          ),
                          validator: (value){
                            if (value!.isEmpty){
                              return "Please enter your problem!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Row(
                            children: <Widget>[
                              _selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "res/images/photo.png",
                                      width: 50,
                                      height: 50,
                                    ),
                              const SizedBox(width: 8.0),
                              const Text('Image'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    data.insert(data.length, {
                                      "user_id": "currentUser",
                                      "title": _titleController.text,
                                      "content": _descriptionController.text,
                                    });
                                    filteredData = data;
                                    _titleController.clear();
                                    _descriptionController.clear();
                                    _selectedImage = null;
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text(
                                'Create Thread',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SourceSans3",
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _titleController.clear();
                                _descriptionController.clear();
                                _selectedImage = null;
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SourceSans3",
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 66),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
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
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Find threads...',
                    hintStyle: const TextStyle(
                      fontFamily: "SourceSans3",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFFFBAE9E),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                        width: 3.0,
                      ),
                    ),
                    fillColor: const Color(0xfffbedec),
                    filled: false,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _showCreateThreadDialog,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Forum Threads',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: "SourceSans3",
                        ),
                      ),
                      Icon(
                        Icons.add,
                        size: 22,
                        weight: 400,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xFFFBAE9E),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredData.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == filteredData.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print(
                                "Đã nhấn để xem thread + ${filteredData.length}");
                            RouterCustom.router.pushNamed("forum-post");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 62.0, // Chiều rộng của hình vuông
                                  height: 62.0, // Chiều cao của hình vuông
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('res/images/avatar.png'),
                                      // Hình ảnh avatar
                                      fit: BoxFit
                                          .cover, // Đảm bảo hình ảnh phủ kín toàn bộ container
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width *0.25,
                                                child: Text(
                                                  filteredData[index]['title']!,
                                                  style: const TextStyle(
                                                    fontFamily: "SourceSans3",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                filteredData[index]['user_id']!,
                                                style: const TextStyle(
                                                  fontFamily: "SourceSans3",
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('16'),
                                              SizedBox(width: 5,),
                                              Image(
                                                  image: AssetImage(
                                                      "res/images/message.png")),
                                              Icon(Icons.arrow_forward_ios),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        filteredData[index]['content']!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: "SourceSans3",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0xFFFBAE9E),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
