import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neowebetu/blocs/exams_notes/exams_notes_bloc.dart';
import 'package:neowebetu/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForegroundService {
  final platform = const MethodChannel('io.aliakrem/foreground_service');
  final backgroundChannel =
      const MethodChannel('io.aliakrem/background_channel');

  Future<void> startService() async {
    try {
      _setupBackgroundChannel();

      await platform.invokeMethod('startService');
    } catch (e) {
      print('Error starting foreground service: $e');
    }
  }

  Future<void> stopService() async {
    try {
      await platform.invokeMethod('stopService');
    } catch (e) {
      print('Error stopping foreground service: $e');
    }
  }

  void _setupBackgroundChannel() {
    backgroundChannel.setMethodCallHandler((call) async {
      if (call.method == 'revalidate') {
        try {
          final prefs = await SharedPreferences.getInstance();
          final bool isAuthed = AuthService(prefs).isAuthenticated();
          if (isAuthed) {
            final examBloc = ExamsNotesBloc();
            examBloc.add(RevalidateExamNotesEvent());
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) async {

              print('FLUTTER: SERVICE STOPPED');
              await stopService();
            });
          }
        } catch (e) {
          print('Error revalidating exams: $e');
        }
      }
    });
  }
}
