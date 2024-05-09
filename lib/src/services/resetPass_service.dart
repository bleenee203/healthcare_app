import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;


void resetPass(String mail, String pass, BuildContext context) async {
  if (pass.isNotEmpty) {
    var url = dotenv.env['URL'];
    var regBody = {
      "email": mail,
      "password": pass
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
        context.go('/success');
      } else {
        print("SomeThing Went Wrong");
      }
    } catch (e) {
      print("Lỗi: $e");
    }
  }
}