import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/exams_notes.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/periods.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/blocs/exams_notes/exams_notes_bloc.dart';
import 'package:webtu_v2/blocs/period/period_bloc.dart';
import 'package:webtu_v2/blocs/session/session_bloc.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';
import 'package:webtu_v2/route.dart';
import './theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, required this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    final SessionBloc sessionBloc = SessionBloc();

    return AdaptiveTheme(
      light: appThemeLight,
      dark: appThemeDark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sessionBloc),
            BlocProvider(
              create: (context) => StudentBloc(
                  studentRepository: StudentRepository(),
                  sessionBloc: sessionBloc,
                  periodBloc: PeriodBloc(periodRepository: PeriodRepository()))
                ..add(GetStudentEvent()),
            ),
          ],
          child: MaterialApp.router(
            title: 'Student Portal',
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            routerConfig: appRoutes,
          )),
    );
  }
}
