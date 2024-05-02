import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookieManager extends Interceptor {
  static final CookieManager _instance = CookieManager._internal();

  static CookieManager get instance => _instance;

  CookieManager._internal();

  String? _cookie;

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode == 200) {
      if (response.headers.map['set-cookie'] != null) {
        _saveCookie(response.headers.map['set-cookie']![0]);
      }
    } else if (response.statusCode == 401) {
      _clearCookie();
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    debugPrint('Current cookie $_cookie');
    options.headers['Cookie'] = _cookie;
    return super.onRequest(options, handler);
  }

  Future<void> initCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cookie = prefs.getString('refreshCookie');
  }

  void _saveCookie(String newCookie) async {
    if (_cookie != newCookie) {
      _cookie = newCookie;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('refreshCookie', _cookie!);
    }
  }

  void _clearCookie() async {
    _cookie = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('refreshCookie');
  }
}
