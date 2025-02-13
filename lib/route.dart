import 'package:webtu_v2/screens/login_screen.dart';
import 'package:webtu_v2/screens/auth_guard.dart';
import 'package:webtu_v2/screens/dashboard/student_dashboard.dart';

var appRoutes = {
  '/': (context) =>  AuthGuard(),
  '/login': (context) =>  LoginScreen(),
  '/dashboard': (context) =>  StudentDashboard(),
};