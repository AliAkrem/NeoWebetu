import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';
import 'package:webtu_v2/models/student.dart';
import 'package:webtu_v2/screens/dashboard/components/actionGrid.dart';
import 'package:webtu_v2/screens/dashboard/components/app_bar.dart';
import 'package:webtu_v2/shared/shared.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: HomeAppBar(),
        body: StudentContainer(context));
  }
}

Widget StudentContainer(context) {
  return BlocBuilder<StudentBloc, StudentState>(
    builder: (context, state) {
      if (state is StudentLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is StudentLoaded) {
        final student = state.student;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, ${student.firstNameLatin}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Here's an overview of your academic progress",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudentStatsGrid(student: student),
                    const SizedBox(height: 32),
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    const QuickActionsGrid(),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      if (state is StudentNotFound ||
          state is FailureState ||
          state is SignInFailureState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed('/login');
        });

        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

class StudentStatsGrid extends StatelessWidget {
  final Student student;

  const StudentStatsGrid({
    super.key,
    required this.student,
  });

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
        StatCard(
          title: 'User ID',
          value: '${student.id}',
          icon: Icons.person_outline,
          color: const Color(0xFF18181B),
        ),
        StatCard(
          title: 'NAME',
          value: '${student.firstNameLatin} ${student.lastNameLatin}',
          icon: Icons.school_outlined,
          color: const Color(0xFF18181B),
        ),
        StatCard(
          title: 'Individual ID',
          value: '${student.socialSecurityNumber}',
          icon: Icons.badge_outlined,
          color: const Color(0xFF18181B),
        ),
      ],
    );
  }
}
