import 'package:flutter/material.dart';
import 'package:webtu_v2/features/auth_guard.dart';
import 'package:webtu_v2/features/cards/cards.dart';
import 'package:webtu_v2/features/home/layout.dart';
import 'package:webtu_v2/features/home/profile/profile.dart';
import 'package:webtu_v2/features/login/login.dart';
import 'package:webtu_v2/features/home/home.dart';

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
          path: '/home',
          pageBuilder: (context, state) => NoTransitionPage(
            child: StudentDashboard(),
          ),
        ),
        GoRoute(
          path: '/home/profile',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/home/cards',
          pageBuilder: (context, state) => NoTransitionPage(
            child: CardsScreen(),
          ),
        ),
      ],
    ),
  ],
);
