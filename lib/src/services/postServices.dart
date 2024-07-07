import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/postModel.dart';

class PostService {
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

  Future<List<Post>?> fetchPost() async {
    await initVariables();
    if (isExpired) {
      await refreshAccessToken();
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return null;
    }
    try {
      final response = await http.get(
        Uri.parse('${url}post/get-all-post'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body)['posts'];
        return jsonResponse.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load post data');
      }
    } catch (error, stackTrace) {
      print('Error fetching post data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
  Future<Post?> getPost(String id) async {
    await initVariables();
    try {
      final response = await http.get(
        Uri.parse('${url}post/get-post/$id'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return Post.fromJson(data);
      }
      return null;
    } catch (error, stackTrace) {
      print('Error fetching post data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }



  Future<String> addPost(Post post) async {
    await initVariables();
    if (isExpired) {
      await refreshAccessToken();
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return '';
    }

    try {
      final newData = post.toJson();
      final requestBody = jsonEncode({'userId': userId, "newData": newData});

      // Print the body of the request
      print('Request Body: $requestBody');
      final response = await http.post(
        Uri.parse('${url}post/create-post'),
        body: jsonEncode({'userId': userId, "newData": newData}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      return ('${jsonDecode(response.body)['message']}');
    } catch (error, stackTrace) {
      print('Stack trace: $stackTrace');
      return ('Error fetching post data: $error');
    }
  }


  Future<bool?> deletePost(String? post_id) async {
    await initVariables();
    if (isExpired) {
      await refreshAccessToken();
    }
    if (accessToken == null || isExpired) {
      print('no valid access token');
      return null;
    }
    try {
      final response = await http.patch(
        Uri.parse('${url}post/delete-post/$post_id'),
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
      print('Error deleting post: $e');
    }
  }

  Future<Map<String, dynamic>?> updateFood(String id, Food updateData) async {
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
          return updateFood(id, updateData);
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
      print(Uri.parse('${url}food/update-food/$id'));
      final response = await http.patch(
        Uri.parse('${url}food/update-food/$id'),
        body: jsonEncode({'newData': newData}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );
      return jsonDecode(response.body);
    } catch (error, stackTrace) {
      print('Error updating user data: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}
