import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/models/mealModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MealService {
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

  Future<List<Map<String, dynamic>>> fetchMeal(String date) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return fetchMeal(date);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return [];
    }
    print("datewedfw $date");
    try {
      final response = await http.get(
        Uri.parse('${url}meal/get-meal?user_id=$userId&date=$date'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        final meals = decodedResponse['meals'] as List<dynamic>;
        // Kiểm tra và chuyển đổi từng phần tử trong danh sách meals thành Map<String, dynamic>
        List<Map<String, dynamic>> parsedMeals = [];
        meals.forEach((meal) {
          if (meal is Map<String, dynamic>) {
            parsedMeals.add(meal);
          } else {
            print('Invalid meal data found: $meal');
          }
        });

        return parsedMeals;
      } else {
        throw Exception('Failed to load meals data');
      }
    } catch (error, stackTrace) {
      print('Error fetching food data: $error');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  // Future<List<Food>?> fetchUserFood() async {
  //   await initVariables();
  //   if (isExpired) {
  //     await refreshAccessToken();
  //   }
  //   if (accessToken == null || isExpired) {
  //     print('no valid access token');
  //     return null;
  //   }
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${url}food/get-all-user-food/$userId'),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonResponse = jsonDecode(response.body)['foods'];
  //       return jsonResponse.map((food) => Food.fromJson(food)).toList();
  //     } else {
  //       throw Exception('Failed to load food data');
  //     }
  //   } catch (error, stackTrace) {
  //     print('Error fetching food data: $error');
  //     print('Stack trace: $stackTrace');
  //     return null;
  //   }
  // }

  Future<String> addFood(Meal meal) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return addFood(meal);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return '';
    }

    try {
      final newData = meal.toJson();
      final requestBody = jsonEncode({'userId': userId, "newData": newData});
      // Print the body of the request
      print('Request Body: $requestBody');
      final response = await http.post(
        Uri.parse('${url}meal/create-meal'),
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

  // Future<List<Food>?> searchFood(String name) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${url}food/search-food?name=$name'),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       List<dynamic> data = jsonDecode(response.body);
  //       List<Food>? results = data.map((food) => Food.fromJson(food)).toList();
  //       return results;
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Error searching food: $e');
  //   }
  // }

  // Future<List<Food>?> searchUserFood(String name) async {
  //   await initVariables();
  //   if (isExpired) {
  //     await refreshAccessToken();
  //   }
  //   if (accessToken == null || isExpired) {
  //     print('no valid access token');
  //     return null;
  //   }
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${url}food/search-user-food?name=$name&id=$userId'),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       List<dynamic> data = jsonDecode(response.body);
  //       List<Food>? results = data.map((food) => Food.fromJson(food)).toList();
  //       return results;
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Error searching food: $e');
  //   }
  // }

  Future<bool> removeFood(String meal_id) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return removeFood(meal_id);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return false;
    }
    try {
      final response = await http.patch(
        Uri.parse('${url}meal/remove-food/$meal_id'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting food: $e');
    }
    return false;
  }

  // Future<Map<String, dynamic>?> updateFood(String id, Food updateData) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? accessToken = prefs.getString('accessToken');
  //   String? refreshToken = prefs.getString('refreshToken');
  //   String? userId = prefs.getString('userId');
  //   var url = dotenv.env['URL'];
  //   if (accessToken == null || refreshToken == null) {
  //     print('Missing access token or refresh token');
  //     return null;
  //   }
  //   bool isExpired = JwtDecoder.isExpired(accessToken);
  //   if (isExpired) {
  //     print('Access token expired, refreshing...');
  //     try {
  //       final response = await http.post(Uri.parse('${url}user/reauth'),
  //           headers: {'Cookie': refreshToken});
  //       if (response.statusCode == 201) {
  //         var jsonResponse = jsonDecode(response.body);
  //         prefs.setString('accessToken', jsonResponse['accessToken']);
  //         accessToken = prefs.getString('accessToken');
  //         print('Refreshed access token successfully');
  //         return updateFood(id, updateData);
  //       } else {
  //         throw Exception('Failed to refresh access token');
  //       }
  //     } catch (error) {
  //       print('Error refreshing access token: $error');
  //       return null;
  //     }
  //   }
  //   try {
  //     final newData = updateData.toJson();
  //     final response = await http.patch(
  //       Uri.parse('${url}food/update-food/$id'),
  //       body: jsonEncode({'newData': newData}),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     return jsonDecode(response.body);
  //   } catch (error, stackTrace) {
  //     print('Error updating user data: $error');
  //     print('Stack trace: $stackTrace');
  //     return null;
  //   }
  // }
}
