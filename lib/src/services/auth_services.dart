import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/widgets/custome_snackBar.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
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
        print(prefs.getString('refreshToken'));
        print(prefs.getString('email'));
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


void logoutUser() async {
  try {
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

    // Logout using the refreshed access token
    http.Response logoutResponse = await http.post(
      Uri.parse('${url}user/logout'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Cookie': refreshToken
      },
    );

    if (logoutResponse.statusCode == 205) {
      prefs.remove('accessToken');
      prefs.remove('refreshToken');
      prefs.remove('email');
      print('Logout success');
    } else {
      print('Logout failed: ${logoutResponse.body}');
    }
  } catch (error) {
    print('Logout error: $error');
  }
}

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
void forgotPass(final emailController, BuildContext context) async {
  if (emailController.text.isNotEmpty ) {
    final mail = emailController.value.text;
    var url = dotenv.env['URL'];
    var regBody = {
      "email": emailController.value.text,
    };
    try {
      var response = await http.post(Uri.parse("${url}user/forgotpass"),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonEncode(regBody));
      print(jsonResponse);
      print(jsonResponse['success']);
      if (jsonResponse['success']) {
        context.push('/verify2/$mail');
      } else {
        print("SomeThing Went Wrong");
      }
    }
    catch (e) {
      print("Lỗi: $e");
    }
  }
}