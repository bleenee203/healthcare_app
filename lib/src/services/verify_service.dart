import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void verifyUser2(List<String> otpValues, String email,BuildContext context) async {
  String otp = otpValues.join();
  int otpInt = int.parse(otp);
  var url = dotenv.env['URL'];
  var regBody = {
    "email": email,
    "otp": otpInt,
  };
  var response = await http.post(Uri.parse("${url}user/verifyotp"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody)
  );
  var jsonResponse = jsonDecode(response.body);
  print(jsonEncode(regBody));
  print(jsonResponse['success']);
  if (jsonResponse['success']) {
    context.push('/resetpass/$email');
  } else {
    print("SomeThing Went Wrong");
  }
}

void verifyUser(List<String> otpValues, String email, String password,BuildContext context) async {
  String otp = otpValues.join();
  int otpInt = int.parse(otp);
  var url = dotenv.env['URL'];
  var regBody = {
    "email": email,
    "password": password,
    "otp": otpInt,
    "confirmedPassword": password
  };
  var response = await http.post(Uri.parse("${url}user/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody));
  var jsonResponse = jsonDecode(response.body);
  print(jsonEncode(regBody));
  print(jsonResponse['success']);
  if (jsonResponse['success'] != null) {
    if (jsonResponse['success']) {
      context.push('/success');
    } else {
      String mess = jsonResponse['message'];
      print(mess);
    }
  }
}
