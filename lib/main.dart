
import 'package:flutter/material.dart';
import 'package:healthcare_app/app.dart';
import 'package:healthcare_app/src/presentation/pages/cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CookieManager.instance.initCookie();
  runApp(const MyApp());
}

