import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcare_app/src/models/drinkModel.dart';
import 'package:healthcare_app/src/models/exerciseModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ExerciseService {
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

  // Future<List<Map<String, dynamic>>> fetchDrink(String date) async {
  //   await initVariables();
  //   if (isExpired) {
  //     if (await refreshAccessToken()) {
  //       return fetchDrink(date);
  //     }
  //   }
  //   if (accessToken == null || isExpired) {
  //     print('no valid access token');
  //     return [];
  //   }
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           '${url}drink/get-water-week?user_id=$userId&weekStartDate=$date'),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //
  //     final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //     final drinks = decodedResponse['drinks'] as List<dynamic>;
  //     print(drinks);
  //     List<Map<String, dynamic>> parsedDrinks = [];
  //     drinks.forEach((drink) {
  //       if (drink is Map<String, dynamic>) {
  //         parsedDrinks.add(drink);
  //       } else {
  //         print('Invalid drink data found: $drink');
  //       }
  //     });
  //
  //     return parsedDrinks;
  //   } catch (error, stackTrace) {
  //     print('Error fetching drink data: $error');
  //     print('Stack trace: $stackTrace');
  //     return [];
  //   }
  // }

  Future<Exercise?> addExerciseLog(Exercise newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? refreshToken = prefs.getString('refreshToken');
    String? userId = prefs.getString('userId');
    print("UserID ne: $userId");
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
          return addExerciseLog(newData);
        } else {
          throw Exception('Failed to refresh access token');
        }
      } catch (error) {
        print('Error refreshing access token: $error');
        return null;
      }
    }
    try {
      final data = newData.toJson();
      final response = await http.post(
        Uri.parse('${url}exercise/create-exercise'),
        body: jsonEncode({'userId': userId, 'newData': data}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(jsonEncode({'userId': userId, 'newData': newData}));
      if (response.statusCode == 200) {
        final Map<String?, dynamic> jsonResponse = jsonDecode(response.body);
        print("result ${jsonResponse['success']}");
        return Exercise.fromJson(jsonResponse['Exercise']);
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (error, stackTrace) {
      print('Error updating user data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchExercise(String date) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return fetchExercise(date);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return [];
    }
    try {
      final response = await http.get(
        Uri.parse(
            '${url}exercise/get-exercise-week?user_id=$userId&weekStartDate=$date'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );

      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final exercises = decodedResponse['exercises'] as List<dynamic>;
      print(exercises);
      List<Map<String, dynamic>> parsedExercises = [];
      exercises.forEach((exercise) {
        if (exercise is Map<String, dynamic>) {
          parsedExercises.add(exercise);
        } else {
          print('Invalid drink data found: $exercise');
        }
      });

      return parsedExercises;
    } catch (error, stackTrace) {
      print('Error fetching drink data: $error');
      print('Stack trace: $stackTrace');
      return [];
    }
  }
}
