import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcare_app/src/models/drinkModel.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/models/mealModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DrinkService {
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

  Future<bool> refreshAccessToken() async {
    if (refreshToken == null) {
      print('No refresh token available');
      return false;
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
        return true;
      } else {
        throw Exception('Failed to refresh access token');
      }
    } catch (error) {
      print('Error refreshing access token: $error');
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> fetchDrink(String date) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return fetchDrink(date);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return [];
    }
    try {
      final response = await http.get(
        Uri.parse(
            '${url}drink/get-water-week?user_id=$userId&weekStartDate=$date'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );

      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final drinks = decodedResponse['drinks'] as List<dynamic>;
      print(drinks);
      List<Map<String, dynamic>> parsedDrinks = [];
      drinks.forEach((drink) {
        if (drink is Map<String, dynamic>) {
          parsedDrinks.add(drink);
        } else {
          print('Invalid drink data found: $drink');
        }
      });

      return parsedDrinks;
    } catch (error, stackTrace) {
      print('Error fetching drink data: $error');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  Future<bool> addWaterLog(int amount) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return addWaterLog(amount);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return false;
    }
    var newData = Drink(amount: amount).toJson();
    try {
      final response = await http.post(
        Uri.parse('${url}drink/create-drink'),
        body: jsonEncode({'userId': userId, "newData": newData}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      if ('${jsonDecode(response.body)['success']}' == 'true') {
        return true;
      }
      return false;
    } catch (error, stackTrace) {
      print('Stack trace: $stackTrace');
      print('Error fetching food data: $error');
      return false;
    }
  }

//   Future<bool> removeFood(String meal_id) async {
//     await initVariables();
//     if (isExpired) {
//       if (await refreshAccessToken()) {
//         return removeFood(meal_id);
//       }
//     }
//     if (accessToken == null || isExpired) {
//       print('no valid access token');
//       return false;
//     }
//     try {
//       final response = await http.patch(
//         Uri.parse('${url}meal/remove-food/$meal_id'),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $accessToken',
//         },
//       );
//       if (response.statusCode == 200) {
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print('Error deleting food: $e');
//     }
//     return false;
//   }
}
