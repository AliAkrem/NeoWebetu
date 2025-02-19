import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/http/requests.dart';
import 'package:webtu_v2/models/exam_notes.dart';

Future<List<ExamNotes>?> getExamNotes() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final cardId = prefs.getInt(CARD_ID);

  if (cardId == null) {
    throw Exception('not current card id');
  }

  try {
    final res = await get(EXAM_NOTES_URL(cardId), true);

    if (res.statusCode == 200) {
      final decodedDataArray = json.decode(res.body);
      //? handle arabic word issue :/

      // Convert Arabic characters correctly and create ExamNotes objects

      final List<ExamNotes> examNotes = (decodedDataArray as List<dynamic>).map<ExamNotes>((module) {
        // Fix Arabic encoding for string values
        (module as Map<String, dynamic>).forEach((key, value) {
          if (value is String) {
            module[key] = utf8.decode(latin1.encode(value));
          }
        });
        return ExamNotes.fromJson(module);
      }).toList();

      return examNotes;
    }
  } catch (e) {
    print(e);
  }
  return null;
}
