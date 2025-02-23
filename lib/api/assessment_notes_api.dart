import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neowebetu/api/exceptions.dart';
import 'package:neowebetu/constant/api_endpoint.dart';
import 'package:neowebetu/models/assessment_notes.dart';
import 'package:neowebetu/utils/http/methods.dart';

class AssessmentNotesResult {
  final List<AssessmentNote> notes;
  final List<String> warnings;

  AssessmentNotesResult({
    required this.notes,
    this.warnings = const [],
  });
}

Future<AssessmentNotesResult> getAssessments() async {
  List<String> warnings = [];

  final prefs = await SharedPreferences.getInstance();

  final cardId = prefs.getInt(CARD_ID);
  if (cardId == null) {
    throw CardNotFoundException();
  }

  try {
    final response = await get(ASSESSMENT_NOTES_URL(cardId), true);

    if (response.statusCode == 200) {
      List<dynamic> decodedDataArray;
      try {
        decodedDataArray = json.decode(response.body);
        if (decodedDataArray.isEmpty) {
          return AssessmentNotesResult(
              notes: [], warnings: ['No exam notes found']);
        }
      } catch (e) {
        throw DataParsingException('Failed to decode JSON response', e);
      }

      List<AssessmentNote> assessmentNotes = [];

      for (var i = 0; i < decodedDataArray.length; i++) {
        try {
          var note = decodedDataArray[i] as Map<String, dynamic>;

          // Handle Arabic character encoding
          _processArabicEncoding(note);

          // Create AssessmentNote object
          final examNote = AssessmentNote.fromJson(note);

          assessmentNotes.add(examNote);
        } catch (e) {
          warnings.add(
              'Warning: Failed to process assessment note at index $i: $e');
          continue;
        }
      }

      return AssessmentNotesResult(notes: assessmentNotes, warnings: warnings);
    } else {
      throw Exception(
          'Failed to load assessment notes: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching assessment notes: $e');
  }
}

// Helper function to process Arabic encoding
void _processArabicEncoding(Map<String, dynamic> data) {
  data.forEach((key, value) {
    if (value is String) {
      try {
        data[key] = utf8.decode(latin1.encode(value));
      } catch (e) {
        print('Warning: Failed to process Arabic encoding for key $key: $e');
      }
    }
  });
}
