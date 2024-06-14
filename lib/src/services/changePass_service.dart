import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/widgets/custome_snackBar.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void changePass (
    String mail, final currentController, final passController, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String current = currentController.value.text;
  String pass = passController.value.text;
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
      http.Response response = await http.patch(Uri.parse('${url}user/changepass'),
        body: jsonEncode(regBody),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken'
          },
          );

      var jsonResponse = jsonDecode(response.body);
      print(jsonEncode(regBody));
      print(jsonResponse);
      print(jsonResponse['success']);
      if (jsonResponse['success'] != null) {
        if (jsonResponse['success']) {
          showSuccessSnackBar("SUCCESS", "Password changed successfully", context);
          context.go('/tabs');
        } else {
          print("SomeThing Went Wrong");
        }
      } else {
        if (jsonResponse['error'] != null) {
          String mess = jsonResponse['feedback'];
          showErrorSnackBar("ERROR1", mess, context);
        }
      }
    } catch (e) {
      print("Lỗi: $e");
    }
  }
}
