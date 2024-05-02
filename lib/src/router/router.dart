import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/pages/Success_screen.dart';
import 'package:healthcare_app/src/presentation/pages/change-password.dart';
import 'package:healthcare_app/src/presentation/pages/login_screen.dart';
import 'package:healthcare_app/src/presentation/pages/personality_screen.dart';
import 'package:healthcare_app/src/presentation/pages/profile_screen.dart';
import 'package:healthcare_app/src/presentation/pages/resetPassword_screen.dart';
import 'package:healthcare_app/src/presentation/pages/signup_screen.dart';
import 'package:healthcare_app/src/presentation/pages/splash_page.dart';
import 'package:healthcare_app/src/presentation/pages/tabs.dart';
import 'package:healthcare_app/src/presentation/pages/verify_screen.dart';
import 'package:healthcare_app/src/presentation/pages/water_screen.dart';

import '../presentation/pages/register_screen.dart';

class RouterCustom {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/resetpass', // Path cho giao diện splash
        name: 'resetpass',
        builder: (BuildContext context, GoRouterState state) =>
            const ResetPassword(), // Hiển thị LoginPage
      ),
      GoRoute(
        path: '/login', // Path cho giao diện đăng nhập
        name: 'login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(), // Hiển thị LoginPage
      ),
      GoRoute(
        path: '/signup', // Path cho giao diện splash
        name: 'signup',
        builder: (BuildContext context, GoRouterState state) =>
            const SignupPage(), // Hiển thị LoginPage
      ),
      GoRoute(
        path: '/tabs', // Path cho giao diện splash
        name: 'tabs',
        builder: (BuildContext context, GoRouterState state) =>
            const MyTabs(), // Hiển thị LoginPage
      ),
      GoRoute(
        path: '/verify', // Path cho giao diện splash
        name: 'verify',
        builder: (BuildContext context, GoRouterState state) =>
            const Verify(), // Hiển thị LoginPage
      ),
      GoRoute(
        path: '/success', // Path cho giao diện splash
        name: 'success',
        builder: (BuildContext context, GoRouterState state) =>
            const Success(), // Hiển thị LoginPage
      ),
      GoRoute(
        path: '/register', // Path cho giao diện splash
        name: 'register',
        builder: (BuildContext context, GoRouterState state) =>
            const Register(), // Hiển thị LoginPage
      ),
      GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (BuildContext context, GoRouterState state) =>
              const ProfilePage()),
      GoRoute(
          path: '/change-password',
          name: 'change-password',
          builder: (BuildContext context, GoRouterState state) =>
              const ChangePasswordPage()),
      GoRoute(
          path: '/personality',
          name: 'personality',
          builder: (BuildContext context, GoRouterState state) =>
              const PersonalityPage()),
      GoRoute(
          path: '/water',
          name: 'water',
          builder: (BuildContext context, GoRouterState state) =>
              const WaterPage()),
    ],
  );
}
