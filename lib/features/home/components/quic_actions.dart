import 'package:flutter/material.dart';
import 'package:webtu_v2/shared/shared.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ActionCard(
          title: 'Course Schedule',
          subtitle: 'View your weekly schedule',
          icon: Icons.calendar_today_outlined,
          onTap: () {
            // TODO: Implement navigation
          },
        ),
        ActionCard(
          title: 'Assignments',
          subtitle: '2 due this week',
          icon: Icons.assignment_outlined,
          onTap: () {
            // TODO: Implement navigation
          },
        ),
        ActionCard(
          title: 'Grades',
          subtitle: 'View your grades',
          icon: Icons.grade_outlined,
          onTap: () {
            // TODO: Implement navigation
          },
        ),
        ActionCard(
          title: 'Resources',
          subtitle: 'Access study materials',
          icon: Icons.library_books_outlined,
          onTap: () {
            // TODO: Implement navigation
          },
        ),
      ],
    );
  }
}
