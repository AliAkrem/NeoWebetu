import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/http/requests.dart';
import 'package:webtu_v2/models/exam_notes.dart';

// Custom exceptions for better error handling
class CardNotFoundException implements Exception {
  final String message;
  CardNotFoundException(
      [this.message = 'No valid card ID found. Please select a card first.']);
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  NetworkException({required this.message, this.statusCode});
  @override
  String toString() =>
      'Network Error: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class DataParsingException implements Exception {
  final String message;
  final dynamic originalError;
  DataParsingException(this.message, [this.originalError]);
  @override
  String toString() =>
      'Data Parsing Error: $message${originalError != null ? ' ($originalError)' : ''}';
}

class ExamNotesResult {
  final List<ExamNotes> notes;
  final List<String> warnings;

  ExamNotesResult({
    required this.notes,
    this.warnings = const [],
  });
}

Future<ExamNotesResult> getExamNotes() async {
  List<String> warnings = [];

  try {
    // Get SharedPreferences instance
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check for card ID
    final cardId = prefs.getInt(CARD_ID);
    if (cardId == null) {
      throw CardNotFoundException();
    }

    // Make API call with timeout
    final response = await get(EXAM_NOTES_URL(cardId), true).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw NetworkException(message: 'Request timed out');
      },
    );

    // Validate response
    if (response.statusCode != 200) {
      throw NetworkException(
        message: 'Failed to fetch exam notes',
        statusCode: response.statusCode,
      );
    }

    // Parse JSON response
    List<dynamic> decodedDataArray;
    try {
      decodedDataArray = json.decode(response.body);
      if (decodedDataArray.isEmpty) {
        return ExamNotesResult(notes: [], warnings: ['No exam notes found']);
      }
    } catch (e) {
      throw DataParsingException('Failed to decode JSON response', e);
    }

    // Process exam notes
    List<ExamNotes> examNotes = [];

    for (var i = 0; i < decodedDataArray.length; i++) {
      try {
        var module = decodedDataArray[i] as Map<String, dynamic>;

        // Handle Arabic character encoding
        _processArabicEncoding(module);

        // Create ExamNotes object
        final examNote = ExamNotes.fromJson(module);

        // Additional validation if needed
        examNotes.add(examNote);
      } catch (e) {
        warnings.add('Warning: Failed to process module at index $i: $e');
        continue;
      }
    }

    // Return result with any warnings
    return ExamNotesResult(
      notes: examNotes,
      warnings: warnings,
    );
  } on CardNotFoundException {
    rethrow;
  } on NetworkException {
    rethrow;
  } on DataParsingException {
    rethrow;
  } catch (e) {
    throw Exception('Unexpected error while fetching exam notes: $e');
  }
}

// Helper function to process Arabic encoding
void _processArabicEncoding(Map<String, dynamic> module) {
  module.forEach((key, value) {
    if (value is String) {
      try {
        module[key] = utf8.decode(latin1.encode(value));
      } catch (e) {
        print('Warning: Failed to process Arabic encoding for key $key: $e');
      }
    }
  });
}
