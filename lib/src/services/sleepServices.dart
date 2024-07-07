import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcare_app/src/models/drinkModel.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/models/mealModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/sleepModel.dart';

class SleepService {
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

  Future<Map<String, dynamic>> fetchSleep(String date) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return fetchSleep(date);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return {};
    }
    try {
      final response = await http.get(
        Uri.parse(
            '${url}sleep/get-sleep-week?user_id=$userId&weekStartDate=$date'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );

      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final sleeps = decodedResponse['sleeps'] as List<dynamic>;
      print(sleeps);
      print(decodedResponse['avg']);
      List<Map<String, dynamic>> parsedSleeps = [];
      sleeps.forEach((sleep) {
        if (sleep is Map<String, dynamic>) {
          parsedSleeps.add(sleep);
        } else {
          print('Invalid sleep data found: $sleep');
        }
      });
      final avg = decodedResponse['avg'];
      return {'sleeps': parsedSleeps, 'avg': avg};
    } catch (error, stackTrace) {
      print('Error fetching sleep data: $error');
      print('Stack trace: $stackTrace');
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchSleepByMonth(String date) async {
    print("day ladate $date");

    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return fetchSleep(date);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return {};
    }
    try {
      final response = await http.get(
        Uri.parse(
            '${url}sleep/get-sleep-month?user_id=$userId&monthStartDate=$date'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );

      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final sleeps = decodedResponse['sleeps'] as List<dynamic>;
      print(sleeps);
      List<Map<String, dynamic>> parsedSleeps = [];
      sleeps.forEach((sleep) {
        if (sleep is Map<String, dynamic>) {
          parsedSleeps.add(sleep);
        } else {
          print('Invalid sleep data found: $sleep');
        }
      });
      final avg = decodedResponse['avg'];
      return {'sleeps': parsedSleeps, 'avg': avg};
    } catch (error, stackTrace) {
      print('Error fetching sleep data: $error');
      print('Stack trace: $stackTrace');
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchWeekSleepByMonth(String month) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return fetchWeekSleepByMonth(month);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return {};
    }
    try {
      final response = await http.get(
        Uri.parse(
            '${url}sleep/get-sleep-week-month?user_id=$userId&month=$month'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );

      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final sleeps = decodedResponse['sleeps'] as List<dynamic>;
      print(sleeps);
      List<Map<String, dynamic>> parsedSleeps = [];
      sleeps.forEach((sleep) {
        if (sleep is Map<String, dynamic>) {
          parsedSleeps.add(sleep);
        } else {
          print('Invalid sleep data found: $sleep');
        }
      });
      return {'sleeps': parsedSleeps};
    } catch (error, stackTrace) {
      print('Error fetching sleep data: $error');
      print('Stack trace: $stackTrace');
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchMonthDrinkByYear(String date) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return fetchMonthDrinkByYear(date);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return {};
    }
    try {
      final response = await http.get(
        Uri.parse('${url}drink/get-water-year?user_id=$userId&date=$date'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );

      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final drinks = decodedResponse['drinks'] as List<dynamic>;
      final days = decodedResponse['days'] as List<dynamic>;
      final avg = decodedResponse['avg'];
      // print(drinks);
      List<Map<String, dynamic>> parsedDrinks = [];
      drinks.forEach((drink) {
        if (drink is Map<String, dynamic>) {
          parsedDrinks.add(drink);
        } else {
          print('Invalid drink data found: $drink');
        }
      });
      List<Map<String, dynamic>> parsedDays = [];
      days.forEach((day) {
        if (day is Map<String, dynamic>) {
          parsedDays.add(day);
        } else {
          print('Invalid drink data found: $day');
        }
      });
      return {'drinks': parsedDrinks, 'avg': avg, 'days': parsedDays};
    } catch (error, stackTrace) {
      print('Error fetching drink data: $error');
      print('Stack trace: $stackTrace');
      return {};
    }
  }

  Future<bool> addSleepLog(DateTime start_time, DateTime end_time,
      int Duration) async {
    await initVariables();
    if (isExpired) {
      if (await refreshAccessToken()) {
        return addSleepLog(start_time, end_time, Duration);
      }
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return false;
    }
    var newData =
    Sleep(start_time: start_time, end_time: end_time, duration: Duration)
        .toJson();
    try {
      final response = await http.post(
        Uri.parse('${url}sleep/create-sleep'),
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
      print('Error fetching sleep data: $error');
      return false;
    }
  }

}
