import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neowebetu/blocs/period/period_bloc.dart';
import 'package:neowebetu/blocs/session/session_bloc.dart';
import 'package:neowebetu/blocs/student/student_bloc.dart';
import 'package:neowebetu/route.dart';
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
                  sessionBloc: sessionBloc, periodBloc: PeriodBloc())
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
