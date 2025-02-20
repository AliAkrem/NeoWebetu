import 'package:webtu_v2/api/exceptions.dart';
import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/models/student.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_response.dart';
import '../utils/http/methods.dart';

Future<Student> getStudentInfo() async {
  try {
    // Get SharedPreferences instance
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check for session
    final sessionString = prefs.getString(SESSION_KEY);
    if (sessionString == null) {
      throw SessionExpiredException();
    }

    // Parse session data
    late final AuthResponse session;
    try {
      session = AuthResponse.fromJson(json.decode(sessionString));
    } catch (e) {
      throw DataParsingException('Invalid session data format: $e');
    }

    // Make API calls
    final Future<dynamic> studentCardsFuture =
        get(STUDENT_CARDS_URL(session.uuid), true);
    final Future<dynamic> studentImageFuture =
        get(STUDENT_IMAGE_URL(session.uuid), true);

    // Wait for both API calls to complete
    final responses =
        await Future.wait([studentCardsFuture, studentImageFuture])
            .catchError((error) {
      throw NetworkException(message: 'Failed to fetch student data: $error');
    });

    final cardResponse = responses[0];
    final imageResponse = responses[1];

    // Validate response status codes
    if (cardResponse.statusCode != 200) {
      throw NetworkException(
          message: 'Failed to fetch student card data',
          statusCode: cardResponse.statusCode);
    }

    if (imageResponse.statusCode != 200) {
      throw NetworkException(
          message: 'Failed to fetch student image',
          statusCode: imageResponse.statusCode);
    }

    // Parse and decode student data
    Map<String, dynamic> studentData;
    try {
      final List decodedData = json.decode(cardResponse.body);
      if (decodedData.isEmpty) {
        throw DataParsingException('No student data found');
      }
      studentData = decodedData[0];
    } catch (e) {
      throw DataParsingException('Failed to parse student data: $e');
    }

    // Handle character encoding
    try {
      studentData.forEach((key, value) {
        if (value is String) {
          studentData[key] = utf8.decode(latin1.encode(value));
        }
      });
    } catch (e) {
      throw DataParsingException('Character encoding error: $e');
    }

    // Create student object
    try {
      final studentInfo =
          Student.fromJson({...studentData, 'image': imageResponse.body});

      // Save card ID
      await prefs.setInt(CARD_ID, studentInfo.id).catchError((error) {
        print('Warning: Failed to save card ID: $error');

        return true;
        // Continue execution as this is not critical
      });

      return studentInfo;
    } catch (e) {
      throw DataParsingException('Failed to create student object: $e');
    }
  } on SessionExpiredException {
    rethrow; // Let caller handle session expiration
  } on NetworkException {
    rethrow; // Let caller handle network errors
  } on DataParsingException {
    rethrow; // Let caller handle parsing errors
  } catch (e) {
    throw Exception('Unexpected error while fetching student info: $e');
  }
}
