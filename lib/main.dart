import 'package:flutter/material.dart';
import 'package:healthcare_app/app.dart';
import 'package:healthcare_app/src/presentation/pages/cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CookieManager.instance.initCookie();
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}
