import 'package:webtu_v2/DatabaseHelper/Repositories/student.dart';
import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/models/student.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_response.dart';
import '../http/requests.dart';

Future<Student> getStudentInfo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final session =
      AuthResponse.fromJson(json.decode(prefs.getString(SESSION_KEY) ?? ""));

  try {
    final response = await get(INDIVIDUAL_URL(session.uuid), true);
    final imageResponse = await get(STUDENT_IMAGE_URL(session.uuid), true);

    if (response.statusCode == 200 || imageResponse.statusCode == 200) {
      final studentInfo = Student.fromJson(
        {
          ...json.decode(response.body),
          ...{"image": imageResponse.body}
        },
      );


      print(studentInfo);


      return studentInfo;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  } catch (e) {
    throw Exception('Failed to login: $e');
  }
}
