import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/models/student.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_response.dart';
import '../http/requests.dart';

Future<Student> getStudentInfo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString(SESSION_KEY) == null) {
    throw Exception('session expired');
  }

  final session =
      AuthResponse.fromJson(json.decode(prefs.getString(SESSION_KEY) ?? ""));

  try {
    final response = await get(STUDENT_CARDS_URL(session.uuid), true);
    final imageResponse = await get(STUDENT_IMAGE_URL(session.uuid), true);

    final decodedData = json.decode(response.body)[0];
    decodedData.forEach((key, value) {
      if (value is String) {
        decodedData[key] = utf8.decode(latin1.encode(value));
      }
    });

    if (response.statusCode == 200 || imageResponse.statusCode == 200) {
      final studentInfo = Student.fromJson(
        {
          // return the last year info
          //TODO (dev): change with accurate logic to determine the last year to avoid bugs
          ...decodedData,
          ...{"image": imageResponse.body}
        },
      );

      prefs.setInt(CARD_ID, studentInfo.id); //? reference the card_id :/

      return studentInfo;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  } catch (e) {
    throw Exception('Failed to login: $e');
  }
}
