import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/widgets/custome_snackBar.dart';
import 'package:http/http.dart' as http;


void registerUser(final emailController, final passController, final confirmPassController,
    BuildContext context) async {
  if (emailController.text.isNotEmpty &&
      passController.text.isNotEmpty &&
      confirmPassController.text.isNotEmpty) {
    final pass = passController.value.text;
    final mail = emailController.value.text;
    var url = dotenv.env['URL'];
    var regBody = {
      "email": emailController.value.text,
    };
    var response = await http.post(Uri.parse("${url}user/sendotp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['success'] != null){
      print(jsonResponse['success']);
      if(jsonResponse['success']){
        context.go('/verify/$mail/$pass');
      }else{
        showErrorSnackBar('ERROR', jsonResponse['message'], context);
      }
    }
    else {
      showErrorSnackBar("ERROR", 'Something went wrong', context);
    }
  }
}