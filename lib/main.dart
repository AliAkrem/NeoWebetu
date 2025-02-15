import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';
import 'package:webtu_v2/route.dart';
import './theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            StudentBloc(StudentRepository())..add(GetStudentEvent()),
        child: MaterialApp.router(
          title: 'Student Portal',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          routerConfig: appRoutes,
          
        ));
  }
}
