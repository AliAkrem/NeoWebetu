import 'package:flutter/material.dart';
import 'package:neowebetu/shared/shared.dart';

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
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
