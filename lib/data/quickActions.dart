import 'package:flutter/material.dart';

class QuickAction {
  final String title;
  final String? subtitle;
  final IconData icon;
  final String? path;

  const QuickAction({
    required this.title,
    this.subtitle,
    required this.icon,
    this.path,
  });
}

final List<QuickAction> quickActions = [
  const QuickAction(
    title: 'Exams',
    icon: Icons.school,
    path: '/home/exams',
  ),
  const QuickAction(
    title: 'Assessment',
    icon: Icons.edit,
    path: '/home/assessment',
  ),
  const QuickAction(
    title: 'Exam Schedule',
    subtitle: 'View your grades',
    icon: Icons.calendar_month_rounded,
    path: '/home/exam-schedule',
  ),
  const QuickAction(
    title: 'Time Table',
    subtitle: 'View your grades',
    icon: Icons.calendar_month_rounded,
    path: '/home/time-table',
  ),
  
];
