import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';
import 'package:webtu_v2/models/student.dart';
import 'package:webtu_v2/services/auth_service.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  late Future<bool> _authCheckFuture;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authService = AuthService(prefs);
    return authService.isAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is StudentLoaded) {
            Navigator.of(context).pushReplacementNamed('/dashboard');
          } else if (state is FailureState ||
              state is StudentNotFound ||
              state is SignInFailureState) {
            Navigator.of(context).pushReplacementNamed('/login');
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
