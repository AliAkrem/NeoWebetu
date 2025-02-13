import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



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

