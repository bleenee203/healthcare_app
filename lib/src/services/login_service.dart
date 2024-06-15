import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/widgets/custome_snackBar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void loginUser(
    final emailController, final passController, BuildContext context) async {
  if (emailController.value.text.isNotEmpty &&
      passController.value.text.isNotEmpty) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var reqBody = {
      "email": emailController.value.text,
      "password": passController.value.text
    };
    var url = dotenv.env['URL'];
    var response = await http.post(Uri.parse('${url}user/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    print(reqBody);
    print(jsonResponse);
    if (jsonResponse['success'] != null) {
      if (jsonResponse['success']) {
        if (response.headers['set-cookie'] != null) {
          var refreshToken = response.headers['set-cookie'];
          prefs.setString('refreshToken', refreshToken!);
        }
        prefs.setString('accessToken', jsonResponse['accessToken']);
        prefs.setString('email', jsonResponse['loginuser']['email']);
        prefs.setString('userId', jsonResponse['loginuser']['_id']);
        print(prefs.getString('refreshToken'));
        print(prefs.getString('email'));
        print(prefs.getString('userId'));
        showSuccessSnackBar('SUCCES', 'Login success', context);
        context.pushNamed('tabs');
      } else {
        print('Something went wrong');
      }
    } else {
      String mess = jsonResponse['feedback'];
      showErrorSnackBar('ERROR!', mess, context);
    }
  }
}
