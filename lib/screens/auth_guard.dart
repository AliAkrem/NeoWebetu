import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is StudentLoaded) {
             context.go('/dashboard');
          } else if (state is FailureState ||
              state is StudentNotFound ||
              state is SignInFailureState) {
            context.go('/login');
          }
        });
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
