import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void changePass (
    String mail, String current, String pass, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = dotenv.env['URL'];
  String? accessToken = prefs.getString('accessToken');
  String? refreshToken = prefs.getString('refreshToken');
  if (accessToken == null || refreshToken == null) {
    print('Missing access token or refresh token');
    return;
  }
  bool isExpired = JwtDecoder.isExpired(accessToken);

  if (isExpired) {
    print('Access token expired, refreshing...');
    http.Response response = await http.post(
      Uri.parse('${url}user/reauth'),
      headers: {'Cookie': refreshToken},
    );
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      prefs.setString('accessToken', jsonResponse['accessToken']);
      accessToken = prefs.getString('accessToken');
      print('Refreshed access token successfully');
    } else {
      print('Failed to refresh access token');
      return;
    }
  }
  if (pass.isNotEmpty) {
    try {
      var url = dotenv.env['URL'];
      var regBody = {"email": mail, "oldPassword": current, "newPassword": pass};
      var response = await http.patch(Uri.parse("${url}user/changepass"),
          headers: {
            'Content-Type':'application/json',
            'Authorization': 'Bearer $accessToken',
            'Cookie': refreshToken
          },
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonEncode(regBody));
      print(jsonResponse);
      print(jsonResponse['success']);
      if (jsonResponse['success'] != null) {
        if (jsonResponse['success']) {
          context.go('/tabs');
        } else {
          print("SomeThing Went Wrong");
        }
      } else {
        if (jsonResponse['error'] != null) {
          String mess = jsonResponse['feedback'];
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(mess)));
        }
      }
    } catch (e) {
      print("Lỗi: $e");
    }
  }
}
