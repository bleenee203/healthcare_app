import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcare_app/src/presentation/pages/tabs.dart';

class RouterCustom{
  static final GoRouter router = GoRouter(
  //initialLocation: '',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyTabs();
      },
      // routes: <RouteBase>[
      //   GoRoute(
      //     path: '/splash_page',
      //     builder: (BuildContext context, GoRouterState state) {
      //       return SplashPage();
      //     },
      //   ),
      // ],
    ),
  ],
);
}