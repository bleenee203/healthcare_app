import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FoodService {
  late SharedPreferences prefs;
  String? accessToken;
  String? refreshToken;
  String? userId;
  late String url;
  bool isExpired = true;
  Future<void> initVariables() async {
    prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
    refreshToken = prefs.getString('refreshToken');
    userId = prefs.getString('userId');
    url = dotenv.env['URL'] ?? '';

    if (accessToken == null || refreshToken == null) {
      print('Missing access token or refresh token');
      return;
    }
    isExpired = JwtDecoder.isExpired(accessToken!);
  }

  Future<void> refreshAccessToken() async {
    if (refreshToken == null) {
      print('No refresh token available');
      return;
    }
    print('Access token expired, refreshing...');
    try {
      final response = await http.post(Uri.parse('${url}user/reauth'),
          headers: {'Cookie': refreshToken!});
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        await prefs.setString('accessToken', jsonResponse['accessToken']);
        accessToken = jsonResponse['accessToken'];
        isExpired = JwtDecoder.isExpired(accessToken!);
        print('Refreshed access token successfully');
      } else {
        throw Exception('Failed to refresh access token');
      }
    } catch (error) {
      print('Error refreshing access token: $error');
    }
  }

  Future<List<Food>?> fetchFood() async {
    await initVariables();
    if (isExpired) {
      await refreshAccessToken();
    }
    if (accessToken == null || isExpired) {
      print('Unable to fetch food data, no valid access token');
      return null;
    }
    try {
      final response = await http.get(
        Uri.parse('${url}food/get-all-food'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body)['foods'];
        return jsonResponse.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to load food data');
      }
    } catch (error, stackTrace) {
      print('Error fetching food data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<List<Food>?> fetchUserFood() async {
    await initVariables();
    if (isExpired) {
      await refreshAccessToken();
    }
    if (accessToken == null || isExpired) {
      print('Unable to fetch food data, no valid access token');
      return null;
    }
    try {
      final response = await http.get(
        Uri.parse('${url}food/get-all-user-food/$userId'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body)['foods'];
        return jsonResponse.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to load food data');
      }
    } catch (error, stackTrace) {
      print('Error fetching food data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<String> addFood(Food food) async {
    await initVariables();
    if (isExpired) {
      await refreshAccessToken();
    }
    if (accessToken == null || isExpired) {
      print('Unable to fetch food data, no valid access token');
      return '';
    }

    try {
      final newData = food.toJson();
      final requestBody = jsonEncode({'userId': userId, "newData": newData});

      // Print the body of the request
      print('Request Body: $requestBody');
      final response = await http.post(
        Uri.parse('${url}food/create-food'),
        body: jsonEncode({'userId': userId, "newData": newData}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      return ('${jsonDecode(response.body)['message']}');
    } catch (error, stackTrace) {
      print('Stack trace: $stackTrace');
      return ('Error fetching food data: $error');
    }
  }
}
