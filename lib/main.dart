import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';
import 'package:webtu_v2/route.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
        child: ShadApp.materialRouter(
          title: 'Student Portal',
          debugShowCheckedModeBanner: false,
          theme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: ShadColorScheme.fromName('green', brightness: Brightness.dark),
          ),
          routerConfig: appRoutes,
        ));
  }
}
