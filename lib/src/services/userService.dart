import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/models/userModel.dart';
import 'package:healthcare_app/src/presentation/widgets/custome_snackBar.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? refreshToken = prefs.getString('refreshToken');
    String? userId = prefs.getString('userId');
    var url = dotenv.env['URL'];
    if (accessToken == null || refreshToken == null) {
      print('Missing access token or refresh token');
      return null;
    }
    bool isExpired = JwtDecoder.isExpired(accessToken);
    if (isExpired) {
      print('Access token expired, refreshing...');
      try {
        final response = await http.post(Uri.parse('${url}user/reauth'),
            headers: {'Cookie': refreshToken});
        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          prefs.setString('accessToken', jsonResponse['accessToken']);
          accessToken = prefs.getString('accessToken');
          print('Refreshed access token successfully');
          return fetchUserData();
        } else {
          throw Exception('Failed to refresh access token');
        }
      } catch (error) {
        print('Error refreshing access token: $error');
        return null;
      }
    }
    try {
      final response = await http.post(
        Uri.parse('${url}user/me'),
        body: jsonEncode({'userId': userId}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String?, dynamic> jsonResponse = jsonDecode(response.body);
        prefs.setDouble(
            'calo_target', (jsonResponse['user']['calo_target']).toDouble());
        return User.fromJson(jsonResponse['user']);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error, stackTrace) {
      print('Error fetching user data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<User?> updateUserData(User updateData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? refreshToken = prefs.getString('refreshToken');
    String? userId = prefs.getString('userId');
    var url = dotenv.env['URL'];
    if (accessToken == null || refreshToken == null) {
      print('Missing access token or refresh token');
      return null;
    }
    bool isExpired = JwtDecoder.isExpired(accessToken);
    if (isExpired) {
      print('Access token expired, refreshing...');
      try {
        final response = await http.post(Uri.parse('${url}user/reauth'),
            headers: {'Cookie': refreshToken});
        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          prefs.setString('accessToken', jsonResponse['accessToken']);
          accessToken = prefs.getString('accessToken');
          print('Refreshed access token successfully');
          return updateUserData(updateData);
        } else {
          throw Exception('Failed to refresh access token');
        }
      } catch (error) {
        print('Error refreshing access token: $error');
        return null;
      }
    }
    try {
      final newData = updateData.toJson();
      final response = await http.put(
        Uri.parse('${url}user/update-user'),
        body: jsonEncode({'userId': userId, 'newData': newData}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(jsonEncode({'userId': userId, 'newData': newData}));
      if (response.statusCode == 200) {
        final Map<String?, dynamic> jsonResponse = jsonDecode(response.body);
        print("result ${jsonResponse['success']}");
        return User.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (error, stackTrace) {
      print('Error updating user data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  void changePass(String mail, final currentController, final passController,
      BuildContext context) async {
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
        var regBody = {
          "email": mail,
          "oldPassword": current,
          "newPassword": pass
        };
        http.Response response = await http.patch(
          Uri.parse('${url}user/changepass'),
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
            showSuccessSnackBar(
                "SUCCESS", "Password changed successfully", context);
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
}
