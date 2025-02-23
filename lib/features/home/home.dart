import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neowebetu/blocs/student/student_bloc.dart';
import 'package:neowebetu/data/quickActions.dart';
import 'package:neowebetu/shared/shared.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is StudentLoadedState) {
          final student = state.student;
          return Scaffold(
              body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: false,
                pinned: false,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.all(16),
                  centerTitle: true,
                  title: Text(
                    'Welcome back, ${student.firstNameLatin}',
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.fade,
                  ),
                ),
                expandedHeight: 150,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const QuickActionsGrid(),
                  childCount: 1,
                ),
              )
            ],
          ));
        }
        if (state is StudentNotFoundState ||
            state is FailureState ||
            state is SignInFailureState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login');
          });

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),

      itemCount: quickActions.length,
      shrinkWrap: true, //
      itemBuilder: (context, index) {
        return ActionCard(
          title: quickActions[index].title,
          subtitle: quickActions[index].subtitle ?? "",
          icon: quickActions[index].icon,
          onTap: () {
            if (quickActions[index].path != null) {
              context.go(quickActions[index].path!);
            }
          },
        );
      },
    );
  }
}
