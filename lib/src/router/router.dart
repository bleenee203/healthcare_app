import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/pages/Success_screen.dart';
import 'package:healthcare_app/src/presentation/pages/change-password.dart';
import 'package:healthcare_app/src/presentation/pages/foods_screen.dart';
import 'package:healthcare_app/src/presentation/pages/forum_post.dart';
import 'package:healthcare_app/src/presentation/pages/login_screen.dart';
import 'package:healthcare_app/src/presentation/pages/nutrition_screen.dart';
import 'package:healthcare_app/src/presentation/pages/personality_screen.dart';
import 'package:healthcare_app/src/presentation/pages/profile_screen.dart';
import 'package:healthcare_app/src/presentation/pages/resetPassword_screen.dart';
import 'package:healthcare_app/src/presentation/pages/set-water-goal.dart';
import 'package:healthcare_app/src/presentation/pages/signup_screen.dart';
import 'package:healthcare_app/src/presentation/pages/sleep_screen.dart';
import 'package:healthcare_app/src/presentation/pages/splash_page.dart';
import 'package:healthcare_app/src/presentation/pages/tabs.dart';
import 'package:healthcare_app/src/presentation/pages/verify2_screen.dart';
import 'package:healthcare_app/src/presentation/pages/verify_screen.dart';
import 'package:healthcare_app/src/presentation/pages/water-log_screen.dart';
import 'package:healthcare_app/src/presentation/pages/water_goal_screen.dart';
import 'package:healthcare_app/src/presentation/pages/water_screen.dart';

import '../presentation/pages/register_screen.dart';
import '../presentation/pages/set_sleep_goal.dart';
import '../presentation/pages/set_sleep_start.dart';
import '../presentation/pages/sleep_goal_screen.dart';

class RouterCustom {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/', // Path cho giao diện splash
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) =>
            const splash(), // Hiển thị LoginPage
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
          path: '/verify/:mail/:password', // Path cho giao diện splash
          name: 'verify',
          builder: (BuildContext context, GoRouterState state) {
            String? mail = state.pathParameters['mail'];
            String? password = state.pathParameters['password'];
            return Verify(
              mail: mail,
              password: password,
            );
          } // Hiển thị LoginPage
          ),
      GoRoute(
          path: '/verify2/:mail', // Path cho giao diện splash
          name: 'verify2',
          builder: (BuildContext context, GoRouterState state) {
            String? mail = state.pathParameters['mail'];
            return Verify2(mail: mail);
          } // Hiển thị LoginPage
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
          path: '/resetpass/:email', // Path cho giao diện splash
          name: 'resetpass',
          builder: (BuildContext context, GoRouterState state) {
            String? email = state.pathParameters['email'];
            return ResetPassword(email: email);
          } // H
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
      GoRoute(
          path: '/water-log',
          name: 'water-log',
          builder: (BuildContext context, GoRouterState state) =>
              const WaterLogPage()),
      GoRoute(
          path: '/water-goal',
          name: 'water-goal',
          builder: (BuildContext context, GoRouterState state) =>
              const WaterGoalPage()),
      GoRoute(
          path: '/set-water-goal',
          name: 'set-water-goal',
          builder: (BuildContext context, GoRouterState state) =>
              const WaterSetGoalPage()),
      GoRoute(
          path: '/nutrition',
          name: 'nutrition',
          builder: (BuildContext context, GoRouterState state) =>
              const NutritionPage()),
      GoRoute(
          path: '/foods',
          name: 'foods',
          builder: (BuildContext context, GoRouterState state) =>
              const FoodsPage()),
      GoRoute(
          path: '/sleep',
          name: 'sleep',
          builder: (BuildContext context, GoRouterState state) =>
            const SleepPage()),
      GoRoute(
          path: '/sleep-goal',
          name: 'sleep-goal',
          builder: (BuildContext context, GoRouterState state) =>
          const SleepGoalPage()),
      GoRoute(
          path: '/set-sleep-goal',
          name: 'set-sleep-goal',
          builder: (BuildContext context, GoRouterState state) =>
          const SleepSetGoalPage()),
      GoRoute(
          path: '/set-sleep-start',
          name: 'set-sleep-start',
          builder: (BuildContext context, GoRouterState state) =>
          const SleepSetStartPage()),
      GoRoute(
          path: '/forum-post',
          name: 'forum-post',
          builder: (BuildContext context, GoRouterState state) =>
          const ForumPost()),
    ],
  );
}
