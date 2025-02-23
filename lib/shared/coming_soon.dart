import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This feature is under development',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
                onPressed: () {
                  context.go('/home');
                },
                child: const Text('Go Back'))
          ],
        ),
      ),
    );
  }
}
