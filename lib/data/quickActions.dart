import 'package:flutter/material.dart';

class QuickAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? path;

  const QuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.path,
  });
}

final List<QuickAction> quickActions = [
  QuickAction(
    title: 'Exams',
    subtitle: 'View your exams notes',
    icon: Icons.note_outlined,
    path: '/home/exams',
  ),
  QuickAction(
    title: 'Assignments',
    subtitle: '2 due this week',
    icon: Icons.assignment_outlined,
  ),
  QuickAction(
    title: 'Grades',
    subtitle: 'View your grades',
    icon: Icons.grade_outlined,
  ),
  QuickAction(
    title: 'Resources',
    subtitle: 'Access study materials',
    icon: Icons.library_books_outlined,
  ),
];
