import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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
