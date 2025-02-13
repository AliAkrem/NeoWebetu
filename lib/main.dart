import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';
import 'package:webtu_v2/route.dart';
import 'package:webtu_v2/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudentBloc(StudentRepository())..add(GetStudentEvent()),
      child: MaterialApp(
        title: 'Student Portal',
        debugShowCheckedModeBanner: false,
        theme: theme,
        routes: appRoutes,
      ),
    );
  }
}
