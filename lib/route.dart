import 'package:flutter/material.dart';
import 'package:neowebetu/features/auth_guard.dart';
import 'package:neowebetu/features/home/assessment_notes/assessment_notes.dart';
import 'package:neowebetu/features/home/cards/cards.dart';
import 'package:neowebetu/features/home/exams_notes/exams_notes.dart';
import 'package:neowebetu/features/home/layout.dart';
import 'package:neowebetu/features/home/profile/profile.dart';
import 'package:neowebetu/features/login/login.dart';
import 'package:neowebetu/features/home/home.dart';

import 'package:go_router/go_router.dart';
import 'package:neowebetu/shared/coming_soon.dart';

final appRoutes = GoRouter(
  initialLocation: '/',
  errorPageBuilder: (context, state) => const MaterialPage(child:  ComingSoonScreen()),
  routes: [
    GoRoute(
      path: '/',
      name: 'root',
      builder: (context, state) => const AuthGuard(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => MaterialPage<void>(
        child: const LoginScreen(),
        key: state.pageKey,
      ),
    ),
    // Modify the ShellRoute configuration
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) => StudentLayout(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) => MaterialPage(
            child: const StudentDashboard(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'exams',
          path: '/home/exams',
          pageBuilder: (context, state) => MaterialPage(
            child: const ExamsNotesScreen(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'assessment',
          path: '/home/assessment',
          pageBuilder: (context, state) => MaterialPage(
            child: const AssessmentNotesScreen(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'profile',
          path: '/home/profile',
          pageBuilder: (context, state) => MaterialPage(
            child: const ProfileScreen(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'cards',
          path: '/home/cards',
          pageBuilder: (context, state) => MaterialPage(
            child: const CardsScreen(),
            key: state.pageKey,
          ),
        ),
      ],
    ),
  ],
);
