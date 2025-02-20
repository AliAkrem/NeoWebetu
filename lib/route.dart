import 'package:flutter/material.dart';
import 'package:webtu_v2/features/auth_guard.dart';
import 'package:webtu_v2/features/home/assessment_notes/assessment_notes.dart';
import 'package:webtu_v2/features/home/cards/cards.dart';
import 'package:webtu_v2/features/home/exams_notes/exams_notes.dart';
import 'package:webtu_v2/features/home/layout.dart';
import 'package:webtu_v2/features/home/profile/profile.dart';
import 'package:webtu_v2/features/login/login.dart';
import 'package:webtu_v2/features/home/home.dart';

import 'package:go_router/go_router.dart';
import 'package:webtu_v2/shared/comming_soon.dart';

final appRoutes = GoRouter(
  initialLocation: '/',
  errorPageBuilder: (context, state) => MaterialPage(child: ComingSoonScreen()),
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
        child: LoginScreen(),
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
            
            child: StudentDashboard(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'exams',
          path: '/home/exams',
          pageBuilder: (context, state) => MaterialPage(
            canPop: true,
            child: ExamsNotesScreen(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'assessment',
          path: '/home/assessment',
          pageBuilder: (context, state) => MaterialPage(

            child: AssessmentNotesScreen(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'profile',
          path: '/home/profile',
          pageBuilder: (context, state) => MaterialPage(
            child: ProfileScreen(),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          name: 'cards',
          path: '/home/cards',
          pageBuilder: (context, state) => MaterialPage(
            child: CardsScreen(),
            key: state.pageKey,
          ),
        ),
      ],
    ),
  ],
);
