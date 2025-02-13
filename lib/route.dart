import 'package:flutter/material.dart';
import 'package:webtu_v2/screens/auth_guard.dart';
import 'package:webtu_v2/screens/home/layout.dart';
import 'package:webtu_v2/screens/home/profile/profile.dart';
import 'package:webtu_v2/screens/login_screen.dart';
import 'package:webtu_v2/screens/home/home.dart';

import 'package:go_router/go_router.dart';

final appRoutes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGuard(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    // Modify the ShellRoute configuration
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) => StudentLayout(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => NoTransitionPage(
            child: StudentDashboard(),
          ),
        ),
        GoRoute(
          path: '/dashboard/profile',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
  ],
);
