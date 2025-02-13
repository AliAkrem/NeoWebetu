import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radix_icons/radix_icons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StudentLayout extends StatefulWidget {
  final Widget child;

  const StudentLayout({
    super.key,
    required this.child,
  });

  @override
  State<StudentLayout> createState() => _StudentLayoutState();
}

class _StudentLayoutState extends State<StudentLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          elevation: 1,
          height: 65,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _calculateSelectedIndex(context),
          onDestinationSelected: (value) {
            _onItemTapped(value, context);
          },
          destinations: [
            ShadButton.ghost(
              icon: const Icon(Icons.home),
              onPressed: () {
                context.go('/dashboard');
              },
            ),
            ShadButton.ghost(
              icon: const Icon(Icons.credit_card),
              onPressed: () {},
            ),
            ShadButton.ghost(
              icon: const Icon(Icons.person),
              onPressed: () {
                context.go('/dashboard/profile');
              },
            ),
          ],
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard/profile')) return 1;
    if (location.startsWith('/dashboard/exams')) return 2;
    if (location.startsWith('/dashboard/settings')) return 3;
    return 0; // /dashboard is the default index
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/dashboard/profile');
        break;
      case 2:
        context.go('/dashboard/exams');
        break;
      case 3:
        context.go('/dashboard/settings');
        break;
    }
  }
}
