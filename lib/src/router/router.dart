import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/models/foodModel.dart';
import 'package:healthcare_app/src/models/userModel.dart';
import 'package:healthcare_app/src/presentation/pages/Success_screen.dart';
import 'package:healthcare_app/src/presentation/pages/begin_sleep.dart';
import 'package:healthcare_app/src/presentation/pages/change-password.dart';
import 'package:healthcare_app/src/presentation/pages/exercise_goal.dart';
import 'package:healthcare_app/src/presentation/pages/food_detail_screen.dart';
import 'package:healthcare_app/src/presentation/pages/foods_screen.dart';
import 'package:healthcare_app/src/presentation/pages/log_exercise.dart';
import 'package:healthcare_app/src/presentation/pages/login_screen.dart';
import 'package:healthcare_app/src/presentation/pages/nutrition_screen.dart';
import 'package:healthcare_app/src/presentation/pages/personality_screen.dart';
import 'package:healthcare_app/src/presentation/pages/profile_screen.dart';
import 'package:healthcare_app/src/presentation/pages/resetPassword_screen.dart';
import 'package:healthcare_app/src/presentation/pages/select_exercise.dart';
import 'package:healthcare_app/src/presentation/pages/set-water-goal.dart';
import 'package:healthcare_app/src/presentation/pages/set_wake_time.dart';
import 'package:healthcare_app/src/presentation/pages/signup_screen.dart';
import 'package:healthcare_app/src/presentation/pages/sleep_screen.dart';
import 'package:healthcare_app/src/presentation/pages/splash_page.dart';
import 'package:healthcare_app/src/presentation/pages/step_count_page.dart';
import 'package:healthcare_app/src/presentation/pages/tabs.dart';
import 'package:healthcare_app/src/presentation/pages/verify2_screen.dart';
import 'package:healthcare_app/src/presentation/pages/verify_screen.dart';
import 'package:healthcare_app/src/presentation/pages/water-log_screen.dart';
import 'package:healthcare_app/src/presentation/pages/water_goal_screen.dart';
import 'package:healthcare_app/src/presentation/pages/water_screen.dart';
import 'package:healthcare_app/src/presentation/pages/add_food_screen.dart';

import '../presentation/pages/excercise_screen.dart';
import '../presentation/pages/forum_post.dart';
import '../presentation/pages/register_screen.dart';
import '../presentation/pages/set_sleep_goal.dart';
import '../presentation/pages/set_sleep_start.dart';
import '../presentation/pages/sleep_goal_screen.dart';
import '../presentation/pages/sleep_log.dart';

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
          path: '/verify/:mail/:password', //
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
          builder: (BuildContext context, GoRouterState state) {
            final userData = state.extra as User?;
            log("userdata $userData");
            return ProfilePage(userData: userData);
          }),
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
          builder: (BuildContext context, GoRouterState state) {
            final water_target = state.extra as int;
            return WaterSetGoalPage(
              water_target: water_target,
            );
          }),
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
          path: '/add-food',
          name: 'add-food',
          builder: (BuildContext context, GoRouterState state) =>
          const AddFoodPage()),
      GoRoute(
          path: '/food-detail',
          name: 'food-detail',
          builder: (BuildContext context, GoRouterState state) {
            final foodData = state.extra as Food;
            return FoodDetailPage(
              food: foodData,
            );
          }),
      GoRoute(
          path: '/update-food',
          name: 'update-food',
          builder: (BuildContext context, GoRouterState state) {
            final foodData = state.extra as Food;
            return AddFoodPage(
              food: foodData,
            );
          }),
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
      GoRoute(
          path: '/sleep',
          name: 'sleep',
          builder: (BuildContext context, GoRouterState state) =>
          const SleepPage()),
      GoRoute(
          path: '/exercise',
          name: 'exercise',
          builder: (BuildContext context, GoRouterState state) =>
          const ExercisePage()),
      GoRoute(
          path: '/sleep-log',
          name: 'sleep-log',
          builder: (BuildContext context, GoRouterState state) =>
          const SleepLog()),
      GoRoute(
          path: '/set-wake-time',
          name: 'set-wake-time',
          builder: (BuildContext context, GoRouterState state) =>
          const SleepSetWakeTime()),
      GoRoute(
        path: '/begin-sleep/:hour/:min',
        name: 'begin-sleep',
        builder: (BuildContext context, GoRouterState state) {
          int? hour = int.tryParse(state.pathParameters['hour'] ?? '');
          int? min = int.tryParse(state.pathParameters['min'] ?? '');
          return BeginSleepPage(hour, min);
        },
      ),
      GoRoute(
          path: '/step-count/:type',
          name: 'step-count',
          builder: (BuildContext context, GoRouterState state) {
            String? type = state.pathParameters['type'];
            return StepCountPage(type: type,);
          }
      ),
      GoRoute(
          path: '/select-exercise',
          name: 'select-exercise',
          builder: (BuildContext context, GoRouterState state) =>
          const SelectExercise()),
      GoRoute(
          path: '/log-exercise/:acti',
          name: 'log-exercise',
          builder: (BuildContext context, GoRouterState state) {
            String? acti = state.pathParameters['acti'];
            return LogExersise(
              acti: acti,
            );
          }),
      GoRoute(
          path: '/goal-exercise',
          name: 'goal-exercise',
          builder: (BuildContext context, GoRouterState state) =>
          const ExerciseGoal()),
    ],
  );
}
